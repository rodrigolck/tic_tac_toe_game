defmodule TicTacToeGameWeb.GameController do
  use TicTacToeGameWeb, :controller
  import Ecto.Query
  alias TicTacToeGame.{Game, Repo}
  alias TicTacToeGame.Client.TicTacToeUser

  action_fallback TicTacToeGameWeb.FallbackController
    
  def index(conn, %{"status" => status} = params) do
    games =
      (from game in Game, where: game.status == ^status)
      |> Repo.all
    user_hash = 
    render(conn, "index.json", %{games: games})
  end

  def index(conn, _params) do
    games = Repo.all(Game)
    render(conn, "index.json", %{games: games})
  end

  def show(conn, params) do
  end

  def create(conn, params) do
  end

  def delete(conn, params) do
  end

  def move(conn, params) do
  end

  def join(conn, params) do
  end

end
