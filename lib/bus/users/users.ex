defmodule Bus.Users do
  @moduledoc """
  The Users context.
  """
  use GenServer

  alias Bus.Users.User

  # Client
  #
  def start_link do
    GenServer.start_link(__MODULE__, nil, name: :users)
  end

  def init(args) do
    {:ok, args}
  end

  def list_users(_params) do
    {:ok, []}
  end

  def get_user(id) do
    IO.puts "getting user #{id}"
    %User{
      first_name: "Nikolai",
      last_name: "Momot",
      email: "momot.nick@gmail.com"
    }
  end

  def create_user(_params) do
    user = %User{
      first_name: "Nikolai",
      last_name: "Momot",
      email: "momot.nick@gmail.com"
    }

    {:ok, user}
  end
end
