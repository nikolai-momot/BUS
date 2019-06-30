defmodule BusWeb.UserView do
  use BusWeb, :view
  alias BusWeb.UserView

  def render("index.json", %{users: users}) do
    IO.inspect users
    %{
      entries:
        render_many(
          users,
          UserView,
          "user.json"
        ),
    }
  end

  def render("user.json", %{user: user}) do
    %{
      first_name: user.first_name,
      last_name: user.last_name,
      status: user.status,
      email: user.email,
      phone: user.phone,
      id: user.id
    }
  end
end
