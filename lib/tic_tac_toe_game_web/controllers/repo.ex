defmodule TicTacToeGame.Repo do
  use Ecto.Repo, otp_app: :tic_tac_toe_game, adapter: Mongo.Ecto
end
