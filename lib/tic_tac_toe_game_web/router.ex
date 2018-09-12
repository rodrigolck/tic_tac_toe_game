defmodule TicTacToeGameWeb.Router do
  use TicTacToeGameWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TicTacToeGameWeb do
    pipe_through :api
  end
end
