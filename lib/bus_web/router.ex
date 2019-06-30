defmodule BusWeb.Router do
  use BusWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", BusWeb do
    pipe_through(:api)
    get("/users", UserController, :index)
    post("/users", UserController, :create_user)
    put("/users/:id", UserController, :update_user)
    get("/users/:id", UserController, :show_user)
    get("/users/:id/times", UserController, :show_times)
    post("/users/:id/times", UserController, :create_time)
    put("/times/:id", UserController, :update_time)
    get("/times/:id", UserController, :show_time)
  end
end
