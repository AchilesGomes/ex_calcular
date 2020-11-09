defmodule CalculatorApi.Log.RequestLog do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "request_log" do
    field :method, :string
    field :path, :string
    field :params, :string

    timestamps()
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:method, :path, :params])
    |> validate_required([:method, :path, :params])
  end
end
