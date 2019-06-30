defmodule Bus.Users do
  @moduledoc """
  The Users context.
  """
  alias Bus.Repo
  alias Bus.Users.User

  use GenServer

  import Ecto.Query, warn: false

  # Client
  #
  def start_link do
    GenServer.start_link(__MODULE__, nil, name: :users)
  end

  def init(args) do
    {:ok, args}
  end

  def list_users(_params) do
    query = from(u in User)

    with users <- Repo.all(query),
         true <- is_list(users) do
      {:ok, users}
    end
  end

  def get_user(id) do
    with %User{} = user <- Repo.get!(User, id) do
      {:ok, user}
    else
      _ -> raise Bus.NoItemError
    end
  end

  def create_user(attrs \\ %{}) do
    with changeset <- User.changeset(%User{}, attrs),
         {:ok, user} <- Repo.insert(changeset) do
      {:ok, user}
    end
  end
end
