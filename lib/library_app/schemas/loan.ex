defmodule LibraryApp.Schemas.Loan do
  alias LibraryApp.Schemas.Book
  alias LibraryApp.Schemas.Member
  use Ecto.Schema
  import Ecto.Changeset

  schema "loans" do
    field(:loan_date, :date)
    field(:return_date, :date)

    belongs_to(:book, Book)
    belongs_to(:member, Member)

    timestamps()
  end

  @type t :: %__MODULE__{
          loan_date: Date.t(),
          return_date: Date.t(),
          book: Book.t(),
          member: Member.t()
        }

  @doc false
  def changeset(loan, attrs) do
    loan
    |> cast(attrs, [:book_id, :member_id, :loan_date, :return_date])
    |> validate_required([:book_id, :member_id, :loan_date])
  end
end
