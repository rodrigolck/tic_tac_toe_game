# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :tic_tac_toe_game, TicTacToeGameWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bVglvfjNqhRF2VN2Wd79ABXqfzQbOnnxx3gAEL2HRWuKAGNaPZLzmOysebb03r21",
  render_errors: [view: TicTacToeGameWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: TicTacToeGame.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :tic_tac_toe_game, TicTacToeGame.Guardian,
  allowed_algos: ["HS256"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
