defmodule Bus.Users.User do
  @moduledoc """
  This module defines the base tournament schema.
  """

  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias Bus.Users.User
  alias Bus.Repo
  alias Ecto.Changeset

  @optional [
    :phone
  ]

  @required [
    :first_name,
    :last_name,
    :email
  ]

  def fields, do: @required ++ @optional

  # @statuses [
  #   "active"
  # ]

  schema "users" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
    field(:phone, :string)
  end
end
