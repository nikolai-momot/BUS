defmodule BusWeb.UserView do
  use BusWeb, :view
  alias BusWeb.UserView

  def render("index.json", %{users: users}) do
    %{
      page: %{
        entries:
          render_many(
            15,
            UserView,
            "user.json",
            users: users
          )
      }
    }
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id
    }
  end
end
