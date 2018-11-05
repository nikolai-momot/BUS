defmodule BusWeb.UserView do
  use BusWeb, :view
  alias BusWeb.UserView

  def render("index.json", %{users: users}) do
    IO.puts "index"
    %{
      entries:
        render_many(
          users,
          UserView,
          "show.json"
        ),
    }
  end

  def render("show.json", %{user: user}) do
    IO.puts "show"
    IO.inspect user
    %{
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      phone: user.phone
    }
  end
end
