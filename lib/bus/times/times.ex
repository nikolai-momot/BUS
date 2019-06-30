defmodule Bus.Times do
  @moduledoc """
  The Times context.
  """
  use GenServer

  import Ecto.Query, warn: false

  alias Bus.Repo
  alias Bus.Times.Time
  alias Bus.Users.User

  # Client
  #
  def start_link do
    GenServer.start_link(__MODULE__, nil, name: :times)
  end

  def init(args) do
    {:ok, args}
  end

  def list_user_times(%{"id" => id}) do
    query = from(t in Time, where: t.user_id == ^id)

    with times <- Repo.all(query),
         true <- is_list(times) do
          IO.inspect times
      {:ok, times}
    end
  end

  def list_user_times(_params) do
    {:error, "No user_id provided"}
  end

  def list_times(_params) do
    query = from(t in Time)

    with times <- Repo.all(query),
         true <- is_list(times) do
      {:ok, times}
    end
  end

  def get_time(id) do
    with %Time{} = time <- Repo.get!(Time, id) do
      {:ok, time}
    else
      _ -> raise Bus.NoItemError
    end
  end

  def create_time(attrs \\ %{}) do
    with changeset <- User.changeset(%User{}, attrs),
         {:ok, user} <- Repo.insert(changeset) do
      {:ok, user}
    end
  end
end
