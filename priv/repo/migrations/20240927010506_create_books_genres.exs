defmodule LibraryApp.Repo.Migrations.CreateBooksGenres do
  use Ecto.Migration

  def change do
    create table(:books_genres, primary_key: false) do
      add :book_id, references(:books, on_delete: :delete_all), null: false, primary_key: true
      add :genre_id, references(:genres, on_delete: :delete_all), null: false, primary_key: true

      timestamps()
    end

    create index(:books_genres, [:book_id])
    create index(:books_genres, [:genre_id])
  end
end
