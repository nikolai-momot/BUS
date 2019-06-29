defmodule Bus.Repo.Migrations.TimeManagement do
  use Ecto.Migration

  def change do
    create table(:times) do
      add :user_id, :integer
      add :event_time, :utc_datetime
      add :status, :string

      timestamps()  # inserted_at and updated_at
    end
  end
end
