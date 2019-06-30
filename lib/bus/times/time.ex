defmodule Bus.Times.Time do
  @moduledoc """
  This module defines the time schema for managing clocking in/out
  """
  alias Bus.Times.Time
  alias Bus.Repo

  import Ecto.Changeset

  use Ecto.Schema

  @optional []

  @required [
    :user_id,
    :event_time,
    :status
  ]

  def fields, do: @required ++ @optional

  @statuses [
    "on_duty",
    "off_duty"
  ]

  schema "times" do
    field(:user_id, :integer)
    field(:event_time, :utc_datetime)
    field(:status, :string)

    timestamps()
  end

  @doc """
  Prepare time changes to be persisted to the database.
  """
  def changeset(nil, %Time{} = new) do
    empty = Repo.preload(%Time{}, [])
    changeset(empty, new)
  end

  def changeset(
        %Time{id: id_a} = old_time,
        %Time{id: id_b} = new_time
      ) do
    if id_a != id_b do
      raise "Tried to change different times: #{id_a}, #{id_b}."
    end

    old_time
    |> change
    |> put_change(:status, new_time.status)
  end

  @doc """
  Build a changeset for a time

  Common validation rules are checked. The underlying time type can also
  add validation rules as the changeset is passed to
  `Time.changeset/4`.
  """
  def changeset(%Time{} = time, attrs) do
    time
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
