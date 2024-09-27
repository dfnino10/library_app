defmodule LibraryApp.Schemas.Book do
  alias LibraryApp.Schemas.BookGenre
  alias LibraryApp.Schemas.Author
  alias LibraryApp.Schemas.Genre
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field(:title, :string)
    field(:isbn, :string)
    field(:published_date, :date)
    belongs_to(:author, Author)
    has_many(:book_genres, BookGenre)
    has_many(:genres, through: [:book_genres, :genre])

    timestamps()
  end

  @type t :: %__MODULE__{
          title: String.t(),
          isbn: String.t(),
          published_date: Date.t(),
          author: Author.t() | nil,
          book_genres: [BookGenre.t()],
          genres: [Genre.t()]
        }

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :isbn, :published_date, :author_id])
    |> validate_required([:title, :author_id])
    |> assoc_constraint(:author)
  end
end
