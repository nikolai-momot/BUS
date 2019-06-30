defmodule Bus.Users.User do
  @moduledoc """
  This module defines the base user schema.
  """
  alias Bus.Users.User
  alias Bus.Repo

  import Ecto.Changeset

  use Ecto.Schema

  @optional [
    :phone
  ]

  @required [
    :first_name,
    :last_name,
    :status,
    :email
  ]

  def fields, do: @required ++ @optional

  @statuses [
    "active",
    "inactive"
  ]

  schema "users" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:status, :string)
    field(:email, :string)
    field(:phone, :string)

    timestamps()
  end

  @doc """
  Prepare user changes to be persisted to the database.
  """
  def changeset(nil, %User{} = new) do
    empty = Repo.preload(%User{}, [])
    changeset(empty, new)
  end

  def changeset(
        %User{id: id_a} = old_user,
        %User{id: id_b} = new_user
      ) do
    if id_a != id_b do
      raise "Tried to change different users: #{id_a}, #{id_b}."
    end

    old_user
    |> change
    |> put_change(:status, new_user.status)
  end

  @doc """
  Build a changeset for a user

  Common validation rules are checked. The underlying user type can also
  add validation rules as the changeset is passed to
  `User.changeset/4`.
  """
  def changeset(%User{} = user, attrs) do
    user
    |> change
    |> cast(structs_to_maps(attrs), @required ++ @optional)
    |> validate_required(@required)
    |> validate_inclusion(:status, @statuses)
  end

  @doc """
  Convert a struct to a map and walk all its keys, recursively converting any
  structs to maps.
  """
  def structs_to_maps(%{__struct__: _} = struct) do
    struct
    |> Map.from_struct()
    |> structs_to_maps
  end

  def structs_to_maps(%{} = map) do
    map
    |> Stream.filter(fn
      # Prevent NotLoaded associations from being treated as _new_ associations.
      {_, %Ecto.Association.NotLoaded{}} ->
        false

      _ ->
        true
    end)
    |> Stream.map(fn {key, value} -> {key, structs_to_maps(value)} end)
    |> Map.new()
  end

  def structs_to_maps([hd | tail]) do
    [structs_to_maps(hd)] ++ structs_to_maps(tail)
  end

  def structs_to_maps(thing), do: thing
end
