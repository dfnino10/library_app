defmodule LibraryApp.Repo do
  use Ecto.Repo,
    otp_app: :library_app,
    adapter: Ecto.Adapters.Postgres
end
