defmodule BusWeb.UserController do
  @moduledoc """
  Entry point for user API endpoints.
  """
  use BusWeb, :controller

  alias Bus.Users
  alias Bus.Times
  alias BusWeb.TimeView

  action_fallback(BusWeb.FallbackController)

  def socket(conn, params) do
    BusWeb.UserSocket.connect(params, conn)
  end

  def index(conn, params) do
    with {:ok, users} <- Users.list_users(params) do
      render(conn, "index.json", users: users)
    end
  end

  def show_user(conn, %{"id" => id}) do
    with id <- String.to_integer(id),
         {:ok, user} <- Users.get_user(id) do
      render(conn, "user.json", user: user)
    end
  end

  def create_user(conn, %{"user" => params}) do
    with {:ok, user} <- Users.create_user(params) do
      render(conn, "user.json", user: user)
    end
  end

  def update_user(conn, %{"id" => id, "user" => params}) do
    with user <- Users.update_user(id, params) do
      render(conn, "user.json", user: user)
    end
  end

  def show_times(conn, params) do
    with {:ok, times} <- Times.list_user_times(params) do
      render(conn, TimeView, "times.json", times: times)
    end
  end

  def create_time(conn, %{"id" => id, "time" => params}) do
    with {:ok, time} <- Times.create_time(id, params) do
      render(conn, TimeView, "time.json", time: time)
    end
  end

  def update_time(conn, %{"id" => id, "time" => params}) do
    with time <- Times.update_time(id, params) do
      render(conn, TimeView, "time.json", time: time)
    end
  end
end
