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

config :bus, BusWeb.Endpoint,
  http: [port: {:system, "BUS_PORT"}],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :bus, Bus.Repo,
  database: "bus",
  pool_size: 10

config :bus, Bus.AuditRepo, database: "bus"

config :bus, :debug_verify_changesets, false