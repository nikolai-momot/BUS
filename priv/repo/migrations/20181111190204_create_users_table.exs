defmodule Bus.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :status, :string
      add :email, :string
      add :phone, :string

      timestamps()  # inserted_at and updated_at
    end
  end
end
