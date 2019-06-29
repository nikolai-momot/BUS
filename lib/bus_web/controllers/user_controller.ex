defmodule BusWeb.UserController do
  @moduledoc """
  Entry point for user API endpoints.
  """
  use BusWeb, :controller

  alias Bus.Users

  action_fallback(BusWeb.FallbackController)

  def socket(conn, params) do
    BusWeb.UserSocket.connect(params, conn)
  end

  def index(conn, params) do
    with {:ok, users} <- Users.list_users(params) do
      render(conn, "index.json", users: users)
    end
  end

  def show(conn, %{"id" => id}) do
    with id <- String.to_integer(id),
         {:ok, user} <- Users.get_user(id) do
      render(conn, "show.json", user: user)
    end
  end

  def create(conn, %{"user" => params}) do
    with {:ok, user} <- Users.create_user(params) do
      render(conn, "show.json", user: user)
    end
  end
end
