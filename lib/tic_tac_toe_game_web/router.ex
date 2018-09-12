defmodule TicTacToeGameWeb.Router do
  use TicTacToeGameWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug TicTacToeGameWeb.Plugs.AssignUser
  end

  scope "/", TicTacToeGameWeb do
    pipe_through :api
    resources "/games", GameController, only: [:index, :show, :create, :delete] do
      put "/move", GameController, :move
      put "/join", GameController, :join
    end
  end
end
