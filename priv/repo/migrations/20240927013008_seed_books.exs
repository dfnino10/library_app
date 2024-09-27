defmodule LibraryApp.Repo.Migrations.SeedBooks do
  use Ecto.Migration

  def up do
    execute("""
    INSERT INTO books (title, isbn, published_date, author_id, inserted_at, updated_at) VALUES
      ('Harry Potter and the Sorcerer''s Stone', '978-0439708180', '1997-06-26', (SELECT id FROM authors WHERE name = 'J.K. Rowling'), NOW(), NOW()),
      ('Harry Potter and the Chamber of Secrets', '978-0439064873', '1998-07-02', (SELECT id FROM authors WHERE name = 'J.K. Rowling'), NOW(), NOW()),
      ('A Game of Thrones', '978-0553103540', '1996-08-06', (SELECT id FROM authors WHERE name = 'George R.R. Martin'), NOW(), NOW()),
      ('A Clash of Kings', '978-0553108033', '1998-11-16', (SELECT id FROM authors WHERE name = 'George R.R. Martin'), NOW(), NOW()),
      ('The Hobbit', '978-0618968633', '1937-09-21', (SELECT id FROM authors WHERE name = 'J.R.R. Tolkien'), NOW(), NOW()),
      ('The Fellowship of the Ring', '978-0547928210', '1954-07-29', (SELECT id FROM authors WHERE name = 'J.R.R. Tolkien'), NOW(), NOW()),
      ('Murder on the Orient Express', '978-0062693662', '1934-01-01', (SELECT id FROM authors WHERE name = 'Agatha Christie'), NOW(), NOW()),
      ('The Shining', '978-0307743657', '1977-01-28', (SELECT id FROM authors WHERE name = 'Stephen King'), NOW(), NOW()),
      ('It', '978-1501142978', '1986-09-15', (SELECT id FROM authors WHERE name = 'Stephen King'), NOW(), NOW()),
      ('Foundation', '978-0553293357', '1951-06-01', (SELECT id FROM authors WHERE name = 'Isaac Asimov'), NOW(), NOW()),
      ('Foundation and Empire', '978-0553293371', '1952-10-01', (SELECT id FROM authors WHERE name = 'Isaac Asimov'), NOW(), NOW()),
      ('The Old Man and the Sea', '978-0684801223', '1952-09-01', (SELECT id FROM authors WHERE name = 'Ernest Hemingway'), NOW(), NOW()),
      ('Adventures of Huckleberry Finn', '978-0486280615', '1884-12-10', (SELECT id FROM authors WHERE name = 'Mark Twain'), NOW(), NOW()),
      ('Pride and Prejudice', '978-1503290563', '1813-01-28', (SELECT id FROM authors WHERE name = 'Jane Austen'), NOW(), NOW()),
      ('Great Expectations', '978-0141439563', '1861-08-01', (SELECT id FROM authors WHERE name = 'Charles Dickens'), NOW(), NOW()),
      ('The Great Gatsby', '978-0743273565', '1925-04-10', (SELECT id FROM authors WHERE name = 'F. Scott Fitzgerald'), NOW(), NOW()),
      ('To Kill a Mockingbird', '978-0061120084', '1960-07-11', (SELECT id FROM authors WHERE name = 'Harper Lee'), NOW(), NOW()),
      ('War and Peace', '978-0199232765', '1869-01-01', (SELECT id FROM authors WHERE name = 'Leo Tolstoy'), NOW(), NOW()),
      ('Anna Karenina', '978-0143035008', '1877-01-01', (SELECT id FROM authors WHERE name = 'Leo Tolstoy'), NOW(), NOW()),
      ('The Catcher in the Rye', '978-0316769488', '1951-07-16', (SELECT id FROM authors WHERE name = 'J.D. Salinger'), NOW(), NOW()),
      ('1984', '978-0451524935', '1949-06-08', (SELECT id FROM authors WHERE name = 'George Orwell'), NOW(), NOW()),
      ('Animal Farm', '978-0451526342', '1945-08-17', (SELECT id FROM authors WHERE name = 'George Orwell'), NOW(), NOW());
    """)
  end

  def down do
    execute("""
    DELETE FROM books;
    """)
  end
end
