# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :crypto_scan,
  ecto_repos: [CryptoScan.Repo]

# Configures the endpoint
config :crypto_scan, CryptoScanWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/BvA0tuplfgCyqag93kbobsoEcvjZyJ+P/3fULgtbYjIv63B00GtntTWIEmB/AdL",
  render_errors: [view: CryptoScanWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CryptoScan.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Cron Job to send Alerts
config :crypto_scan, CryptoScan.Scheduler,
  jobs: [
     {"*/2 * * * *",      {CryptoScan.Feedback, :emailAlerts, []}},
  ]

# import email api data
import_config "email_api.secret.exs"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
