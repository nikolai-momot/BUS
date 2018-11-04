defmodule Bus.Users do
  @moduledoc """
  The Users context.
  """
  use GenServer

  # Client
  #
  def start_link do
    GenServer.start_link(__MODULE__, nil, name: :users)
  end

  def init(args) do
    {:ok, args}
  end

  def list_users(_params) do
    []
  end
end
