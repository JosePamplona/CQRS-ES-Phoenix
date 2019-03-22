use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :conduit, ConduitWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :comeonin, :bcrypt_log_rounds, 4

# Configure the event store database
config :eventstore, EventStore.Storage,
  serializer: Commanded.Serialization.JsonSerializer,
  migration_timestamps: [type: :naive_datetime_usec],
  username: "postgres",
  password: "pass",
  database: "conduit_eventstore_test",
  hostname: "localhost",
  port: "5432",
  pool_size: 1
  
# Configure the event read database
config :conduit, Conduit.Repo,
  migration_timestamps: [type: :naive_datetime_usec],
  username: "postgres",
  password: "pass",
  database: "conduit_readstore_test",
  hostname: "localhost",
  port: "5432",
  pool_size: 1

config :comeonin, :bcrypt_log_rounds, 4