import Config

config :library_app, LibraryApp.Repo,
  username: "postgres",
  password: "postgres",
  database: "library_app_dev",
  hostname: "db",
  port: 5432,
  pool_size: 10

config :library_app,
  ecto_repos: [LibraryApp.Repo]
