defmodule CalculatorApiWeb.CalculateController do
  use CalculatorApiWeb, :controller

  alias CalculatorApi.Calculate

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{resultado: "Hellou"})
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
