defmodule BusWeb.TimeView do
  use BusWeb, :view
  alias BusWeb.TimeView

  def render("times.json", %{times: times}) do
    IO.inspect times
    %{
      entries:
        render_many(
          times,
          TimeView,
          "time.json"
        ),
    }
  end


  def render("time.json", %{time: time}) do
    IO.inspect "time.json"
    IO.inspect time
    %{
      user_id: time.user_id,
      status: time.status,
      event_time: time.event_time,
    }
  end
end
