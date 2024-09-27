defmodule LibraryApp.Repo.Migrations.CreateMembers do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :name, :string, null: false
      add :email, :string

      timestamps()
    end

    create unique_index(:members, [:email])
  end
end
