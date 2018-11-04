defmodule Bus.Repo do
  use Ecto.Repo, otp_app: :bus

  def init(_type, opts) do
    opts =
      opts
      |> Keyword.put(:username, System.get_env("BUS_DB_USER"))
      |> Keyword.put(:password, System.get_env("BUS_DB_PASS"))
      |> Keyword.put(:hostname, System.get_env("BUS_DB_HOST"))
      |> Keyword.put_new(:database, System.get_env("BUS_DB_NAME"))

    {:ok, opts}
  end

  def log(entry), do: entry
end
