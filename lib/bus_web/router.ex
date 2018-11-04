defmodule BusWeb.Router do
  use BusWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", BusWeb do
    pipe_through(:api)
    get("/users", UsersController, :index)
  end
end
