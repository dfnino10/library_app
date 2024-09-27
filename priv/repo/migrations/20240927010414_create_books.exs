defmodule LibraryApp.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string, null: false
      add :isbn, :string
      add :published_date, :date
      add :author_id, references(:authors, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:books, [:author_id])
  end
end
