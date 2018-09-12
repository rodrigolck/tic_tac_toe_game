defmodule TicTacToeGameWeb.Plugs.AssignUser do
  import Plug.Conn
  alias TicTacToeGame.Guardian

  def init(options), do: options

  def call(conn, _opts) do
    [auth] = get_req_header(conn, "authorization")
    [_, jwt] = Regex.split(~r{ }, auth, [parts: 2])
    %{claims: %{"user_id" => user_id}} = Guardian.peek(jwt)
    assign(conn, :user_id, user_id)
  end

end
