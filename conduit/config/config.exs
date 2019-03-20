# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :conduit,
  ecto_repos: [Conduit.Repo]

# Configures the endpoint
config :conduit, ConduitWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Yu65j6My/O/ZisRN3tGsX3WA/QBE2NI3udAh2OsCRzt5bQhVul74nGuAwppT2xfd",
  render_errors: [view: ConduitWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Conduit.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :commanded_ecto_projections, 
  repo: Conduit.Repo

config :vex,
  sources: [
    Conduit.Accounts.Validators,
    Conduit.Support.Validators,
    Vex.Validators
  ]

config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "Conduit",
  ttl: {30, :days},
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key: "bF+sUIJQbYktyyDUU02ilPwLmreKkNWy3yj5VBwfKFxUDrotEOm0arMxx0sL+DKX",
  serializer: Conduit.Auth.GuardianSerializer
  
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
