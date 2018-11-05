# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# General application configuration
config :bus, ecto_repos: [Bus.Repo]

config :bus, Bus.Repo,
  adapter: Ecto.Adapters.Postgres,
  loggers: [
    {Ecto.LogEntry, :log, []},
    {Bus.Repo, :log, []}
  ]

config :bus, Bus.AuditRepo, adapter: Bus.AuditMigrations

config :bus, Bus.Dispatcher, async: true

# Configures the endpoint
config :bus, BusWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: BusWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Bus.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
