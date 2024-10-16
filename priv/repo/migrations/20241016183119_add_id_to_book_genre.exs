defmodule LibraryApp.Repo.Migrations.AlterBooksGenresPrimaryKey do
  use Ecto.Migration

  def up do
    # Step 1: Drop the existing primary key constraint
    execute("""
    ALTER TABLE books_genres DROP CONSTRAINT books_genres_pkey;
    """)

    # Step 2: Add the new 'id' column with a primary key
    alter table(:books_genres) do
      add :id, :bigserial, primary_key: true
    end

    # Step 3: Add a unique constraint on the combination of book_id and genre_id
    create unique_index(:books_genres, [:book_id, :genre_id], name: :books_genres_unique_index)
  end

  def down do
    # Reverse the changes if needed

    # Step 1: Remove the unique index
    drop index(:books_genres, [:book_id, :genre_id], name: :books_genres_unique_index)

    # Step 2: Remove the 'id' column
    alter table(:books_genres) do
      remove :id
    end

    # Step 3: Re-add the composite primary key
    execute("""
    ALTER TABLE books_genres ADD PRIMARY KEY (book_id, genre_id);
    """)
  end
end
