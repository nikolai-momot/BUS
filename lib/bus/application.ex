defmodule Bus.Application do
  @moduledoc false
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    children=
      [
        supervisor(Bus.Repo, []),
        worker(Bus.Users, []),
        supervisor(BusWeb.Endpoint, [])
      ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bus.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
