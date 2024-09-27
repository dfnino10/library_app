defmodule LibraryApp.Repo.Migrations.SeedBooksGenres do
  use Ecto.Migration

  def up do
    execute("""
    INSERT INTO books_genres (book_id, genre_id, inserted_at, updated_at) VALUES
      ((SELECT id FROM books WHERE title = 'Harry Potter and the Sorcerer''s Stone'), (SELECT id FROM genres WHERE name = 'Fantasy'), NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'Harry Potter and the Sorcerer''s Stone'), (SELECT id FROM genres WHERE name = 'Adventure'), NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'A Game of Thrones'), (SELECT id FROM genres WHERE name = 'Fantasy'), NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'A Game of Thrones'), (SELECT id FROM genres WHERE name = 'Adventure'), NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'The Hobbit'), (SELECT id FROM genres WHERE name = 'Fantasy'), NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'The Hobbit'), (SELECT id FROM genres WHERE name = 'Adventure'), NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'Murder on the Orient Express'), (SELECT id FROM genres WHERE name = 'Mystery'), NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'The Shining'), (SELECT id FROM genres WHERE name = 'Horror'), NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'Foundation'), (SELECT id FROM genres WHERE name = 'Science Fiction'), NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'The Old Man and the Sea'), (SELECT id FROM genres WHERE name = 'Historical'), NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'Adventures of Huckleberry Finn'), (SELECT id FROM genres WHERE name = 'Adventure'), NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'Pride and Prejudice'), (SELECT id FROM genres WHERE name = 'Romance'), NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'Great Expectations'), (SELECT id FROM genres WHERE name = 'Historical'), NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'The Great Gatsby'), (SELECT id FROM genres WHERE name = 'Historical'), NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'To Kill a Mockingbird'), (SELECT id FROM genres WHERE name = 'Historical'), NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'War and Peace'), (SELECT id FROM genres WHERE name = 'Historical'), NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'The Catcher in the Rye'), (SELECT id FROM genres WHERE name = 'Historical'), NOW(), NOW()),
      ((SELECT id FROM books WHERE title = '1984'), (SELECT id FROM genres WHERE name = 'Science Fiction'), NOW(), NOW());
    """)
  end

  def down do
    execute("""
    DELETE FROM books_genres;
    """)
  end
end
