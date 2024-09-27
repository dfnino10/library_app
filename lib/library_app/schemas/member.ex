defmodule LibraryApp.Schemas.Member do
  alias LibraryApp.Schemas.Book
  alias LibraryApp.Schemas.Loan

  use Ecto.Schema
  import Ecto.Changeset

  schema "members" do
    field(:name, :string)
    field(:email, :string)

    has_many(:loans, Loan)
    has_many(:books, through: [:loans, :book])

    timestamps()
  end

  @type t :: %__MODULE__{
          name: String.t(),
          email: String.t(),
          loans: [Loan.t()],
          books: [Book.t()]
        }

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [:name, :email])
    |> validate_required([:name])
    |> unique_constraint(:email)
  end
end
