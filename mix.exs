defmodule Bus.Mixfile do
  use Mix.Project

  def project do
    [
      app: :bus,
      version: "5.9.0",
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),

      # Docs
      name: "Base User Service",
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Bus.Application, []},
      applications: [
        :amqp,
        :countries,
        :cowboy,
        :exometer_core,
        :gen_state_machine,
        :gettext,
        :httpoison,
        :httpotion,
        :jose,
        :logger,
        :phoenix,
        :phoenix_ecto,
        :phoenix_html,
        :phoenix_pubsub,
        :poison,
        :postgrex,
        :scrivener_list,
        :scrivener_ecto,
        :cachex,
        :csv,
        :yamerl,
        :varint,
        :quantum,
        :timex
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:amqp, "~> 1.0.2"},
      {:benchee, "~> 0.11", only: [:dev, :test]},
      {:countries, "~> 1.5"},
      {:cowboy, "~> 1.0"},
      {:credo, "~> 0.9.0", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:exometer_core, "~> 1.5.2"},
      {:exrm, "~> 1.0"},
      {:gen_state_machine, "~> 2.0"},
      {:gettext, "~> 0.11"},
      {:httpoison, "~> 0.13"},
      {:httpotion, "~> 3.0.2"},
      {:jose, "~> 1.8"},
      {:phoenix, "~> 1.3.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_pubsub, "~> 1.0"},
      {:poison, "~> 2.0"},
      {:postgrex, ">= 0.0.0"},
      {:scrivener_ecto, "~> 1.0"},
      {:scrivener_list, "~> 1.0"},
      {:cachex, "~> 2.1"},
      {:csv, "~>2.0"},
      {:varint, "~> 1.0.0"},
      {:quantum, "~> 2.2"},
      {:timex, "~> 3.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
