# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :lager,
  crash_log: false,
  error_logger_redirect: false,
  error_logger_whitelist: [Logger.ErrorLogger],
  handlers: [
    lager_console_backend: [level: :info]
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
