defmodule LibraryApp.Repo.Migrations.SeedLoans do
  use Ecto.Migration

  def up do
    execute("""
    INSERT INTO loans (book_id, member_id, loan_date, return_date, inserted_at, updated_at) VALUES
      ((SELECT id FROM books WHERE title = 'Harry Potter and the Sorcerer''s Stone'), (SELECT id FROM members WHERE email = 'alice@example.com'), '2023-09-01', '2023-09-15', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'A Game of Thrones'), (SELECT id FROM members WHERE email = 'bob@example.com'), '2023-09-05', NULL, NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'The Hobbit'), (SELECT id FROM members WHERE email = 'carol@example.com'), '2023-09-10', '2023-09-20', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'Murder on the Orient Express'), (SELECT id FROM members WHERE email = 'david@example.com'), '2023-09-12', '2023-09-22', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'The Shining'), (SELECT id FROM members WHERE email = 'eve@example.com'), '2023-09-14', '2023-09-24', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'Foundation'), (SELECT id FROM members WHERE email = 'frank@example.com'), '2023-09-16', '2023-09-26', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'The Old Man and the Sea'), (SELECT id FROM members WHERE email = 'grace@example.com'), '2023-09-18', '2023-09-28', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'Adventures of Huckleberry Finn'), (SELECT id FROM members WHERE email = 'hank@example.com'), '2023-09-20', '2023-09-30', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'Pride and Prejudice'), (SELECT id FROM members WHERE email = 'ivy@example.com'), '2023-09-22', '2023-10-02', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'Great Expectations'), (SELECT id FROM members WHERE email = 'jack@example.com'), '2023-09-24', '2023-10-04', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'The Great Gatsby'), (SELECT id FROM members WHERE email = 'karen@example.com'), '2023-09-26', '2023-10-06', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'To Kill a Mockingbird'), (SELECT id FROM members WHERE email = 'leo@example.com'), '2023-09-28', '2023-10-08', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'War and Peace'), (SELECT id FROM members WHERE email = 'mia@example.com'), '2023-09-30', '2023-10-10', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'The Catcher in the Rye'), (SELECT id FROM members WHERE email = 'nina@example.com'), '2023-10-02', '2023-10-12', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = '1984'), (SELECT id FROM members WHERE email = 'oscar@example.com'), '2023-10-04', '2023-10-14', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'Harry Potter and the Sorcerer''s Stone'), (SELECT id FROM members WHERE email = 'paul@example.com'), '2023-10-06', '2023-10-16', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'A Game of Thrones'), (SELECT id FROM members WHERE email = 'quinn@example.com'), '2023-10-08', '2023-10-18', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'The Hobbit'), (SELECT id FROM members WHERE email = 'rita@example.com'), '2023-10-10', '2023-10-20', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'Murder on the Orient Express'), (SELECT id FROM members WHERE email = 'alice@example.com'), '2023-10-12', '2023-10-22', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'The Shining'), (SELECT id FROM members WHERE email = 'bob@example.com'), '2023-10-14', '2023-10-24', NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'Foundation'), (SELECT id FROM members WHERE email = 'carol@example.com'), '2023-10-16', NULL, NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'The Old Man and the Sea'), (SELECT id FROM members WHERE email = 'david@example.com'), '2023-10-18', NULL, NOW(), NOW()),
      ((SELECT id FROM books WHERE title = 'Adventures of Huckleberry Finn'), (SELECT id FROM members WHERE email = 'eve@example.com'), '2023-10-20', NULL, NOW(), NOW());
    """)
  end

  def down do
    execute("""
    DELETE FROM loans;
    """)
  end
end
