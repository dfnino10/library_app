defmodule LibraryApp.Repo.Migrations.SeedGenres do
  use Ecto.Migration

  def up do
    execute("""
    INSERT INTO genres (name, inserted_at, updated_at) VALUES
      ('Fantasy', NOW(), NOW()),
      ('Adventure', NOW(), NOW()),
      ('Science Fiction', NOW(), NOW()),
      ('Mystery', NOW(), NOW()),
      ('Horror', NOW(), NOW()),
      ('Romance', NOW(), NOW()),
      ('Thriller', NOW(), NOW()),
      ('Historical', NOW(), NOW()),
      ('Non-Fiction', NOW(), NOW()),
      ('Biography', NOW(), NOW());
    """)
  end

  def down do
    execute("""
    DELETE FROM genres;
    """)
  end
end
