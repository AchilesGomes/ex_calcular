defmodule CalculatorApi.Log do
  @moduledoc """
  The Login context.
  """

  import Ecto.Query, warn: false

  alias CalculatorApi.Log.RequestLog
  alias CalculatorApi.Repo

  def get_all_params do
    query = from r in RequestLog,
      select: %{registro: r.id, requisicao: r.params}

    Repo.all(query)
  end
end