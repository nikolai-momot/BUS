defmodule BusWeb.UserController do
  @moduledoc """
  Entry point for user API endpoints.
  """
  use BusWeb, :controller

  alias Bus.Users

  def index(conn, params) do
    with {:ok, users} <- Users.list_users(params) do
      render(conn, "index.json", users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    with user <- Users.get_user(id) do
      render(conn, "show.json", user: user)
    end
  end

  def create(conn, %{"user" => params}) do
    with {:ok, user} <- Users.create_user(params) do
      IO.puts "create"
      IO.inspect user
      render(conn, "show.json", user: user)
    end
  end
end
