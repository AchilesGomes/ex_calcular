defmodule CalculatorApiWeb.LoginController do
  use CalculatorApiWeb, :controller

  alias CalculatorApi.Login

  def create(conn, %{"usuario" => usuario, "senha" => senha}) do
    usuario
    |> Login.get_user!()
    |> Login.validate_password(senha)
    |> case do
      {:ok, %{token: token}} ->
        conn
        |> put_status(:created)
        |> json(%{resultado: token})

      {:error, message} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{resultado: message})
    end
  end
end
