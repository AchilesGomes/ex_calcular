# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :calculator_api,
  ecto_repos: [CalculatorApi.Repo]

# Configures the endpoint
config :calculator_api, CalculatorApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gT7C/UooHzSpKJLkOF1iRjMcX41T8M8M5Mm9GkPkUJ92AFj5BzW67OVkQ0XgA3mw",
  render_errors: [view: CalculatorApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: CalculatorApi.PubSub,
  live_view: [signing_salt: "PnwUzFcJ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
