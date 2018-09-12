defmodule TicTacToeGame.Game do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "games" do
    field :history, {:array, :map}, default: [%{"game_state"=>[[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]], "turn"=> nil}]
    field :status, :string, default: "waiting"
    field :winner, :binary_id
    field :loser, :binary_id
    field :user_ids, {:array, :binary_id}, default: []
  end

  @required_fields ~w(history status)
  @optional_fields ~w(winner loser user_ids)
  @valid_status ~w(waiting playing finished)

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_inclusion(:status, @valid_status)
    |> validate_length(:user_ids, min: 1)
    |> validate_length(:user_ids, max: 2)
  end

end
