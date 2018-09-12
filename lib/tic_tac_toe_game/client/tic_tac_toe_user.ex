defmodule TicTacToeGame.Client.TicTacToeUser do
  use TicTacToeGame.Client.Generic

  def get_user(user_id),
    do: try_request(:get, "/users/#{user_id}")
  def get_user!(user_id),
    do: get_user(user_id) |> elem(1)


end
