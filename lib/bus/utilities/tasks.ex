defmodule Bus.Utilities.Tasks do
  @moduledoc """
  Provides common Ecto Mix tasks as commands that are available within
  a production relaese.

  ## Examples

    bin/bus command Elixir.Bus.Utilities.Tasks migrate
  """
  alias Ecto.Migrator

  @doc """
  Run all down migrations
  """
  def migrate(repo \\ Bus.Repo) do
    Migrator.run(repo, repo_path(), :up, all: true)
    :init.stop()
  end

  defp repo_path do
    {:ok, _} = Application.ensure_all_started(:bus)
    # https://github.com/bitwalker/exrm/issues/67#issuecomment-182958019
    Path.join(["#{:code.priv_dir(:bus)}", "repo", "migrations"])
  end
end
