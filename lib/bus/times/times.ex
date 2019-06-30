defmodule Bus.Times do
  @moduledoc """
  The Times context.
  """
  use GenServer

  import Ecto.Query, warn: false

  alias Bus.Repo
  alias Bus.Times.Time
  alias Bus.Users

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

  def create_time(id, %{"status" => status}) do
    now = DateTime.utc_now()
    time = %{user_id: id, event_time: now, status: status}
    with changeset <- Time.changeset(%Time{}, time),
         {:ok, time} <- Repo.insert(changeset) do
      {:ok, time}
    end
  end

  def update_time(id, attrs) do
    IO.inspect id
    with {:ok, time} <- get_time(id),
         changeset <- Time.changeset(time, attrs) do
      Repo.update!(changeset)
    end
  end
end
