defmodule CalculatorApiWeb.CalculateController do
  @moduledoc false

  use CalculatorApiWeb, :controller

  alias CalculatorApi.Calculate
  alias CalculatorApi.Log

  @spec index(struct(), none()) :: map()
  def index(conn, _params) do
    result = Log.get_all_params()

    conn
    |> put_status(:ok)
    |> json(%{data: result})
  end

  @spec create(struct(), map()) :: map()
  def create(conn, %{"calculo" => calculo}) do
    calculo
    |> Calculate.validate
    |> case do
      false ->
        result = Calculate.calculate(calculo)

        conn
        |> put_status(:created)
        |> json(%{resultado: result})

      true ->
        conn
        |> put_status(:ok)
        |> json(%{retorno: "Não utilizei letras no cálculo"})        
    end
  end
end
