defmodule TicTacToeGameWeb.GameView do
  use TicTacToeGameWeb, :view
  alias TicTacToeGame.Client.TicTacToeUser

  def render("index.json", %{games: games}) do
    %{
      games: Enum.map(games, &(game_json(&1)))
    }
  end

  def render("show.json", %{game: game}) do
    game_json(game)
    |> Map.put(:history, history_json(game))
  end

  defp game_json(game) do
    user_hash = get_user_hash(game.user_ids)
    %{
      id: game.id,
      status: game.status,
      users: Enum.map(user_hash, fn({_user_id, user}) -> user["name"] end),
      winner: game.winner && user_hash[game.winner]["name"],
      loser: game.loser && user_hash[game.loser]["name"]
    }
  end

  defp history_json(game) do
    user_hash = get_user_hash(game.user_ids)
    game.history
    |> Enum.map(fn(game_hist) ->
      %{
        game_state: game_state_json(game_hist["game_state"], user_hash),
        turn: game_hist["turn"] && user_hash[game_hist["turn"]]["name"]
      }
    end)
  end

  defp game_state_json(game_state, user_hash) do
    Enum.map(game_state, fn(line) ->
      Enum.map(line, fn(slot) ->
        slot && user_hash[slot]["name"]
      end)
    end)
  end

  defp get_user_hash(user_ids) do
    user_ids
    |> Enum.reduce(%{}, fn(user_id, acc) ->
      Map.put(acc, user_id, TicTacToeUser.get_user!(user_id))
    end)
  end

end