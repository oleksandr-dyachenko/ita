use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ita, ItaWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :ita, Ita.Repo,
  username: "root",
  password: "",
  database: "ita_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
