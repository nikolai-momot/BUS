defmodule BusWeb.UsersController do
  @moduledoc """
  Entry point for user API endpoints.
  """
  use BusWeb, :controller

  alias Bus.Users

  def index(conn, params) do
    {:ok, page} = Users.list_users(params)
    render(conn, "index.json", page)
  end
end
