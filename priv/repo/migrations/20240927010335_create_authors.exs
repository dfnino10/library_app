defmodule LibraryApp.Repo.Migrations.CreateAuthors do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :name, :string, null: false
      add :bio, :text

      timestamps()
    end
  end
end
