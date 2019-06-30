defmodule BusWeb.Router do
  use BusWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", BusWeb do
    pipe_through(:api)
    get("/users", UserController, :index)
    post("/users/create", UserController, :create)
    get("/users/:id", UserController, :show)
    get("/users/:id/times", UserController, :times)
  end
end
