defmodule CalculatorApiWeb.LoginControllerTest do
  use CalculatorApiWeb.ConnCase

  alias CalculatorApi.Login
  alias CalculatorApi.Accounts

  @create_attrs %{
    login: "teste",
    password: "teste"
  }

  @params %{
    "usuario" => "teste",
    "senha" => "teste"
  }

  @invalid_params %{
    "usuario" => "teste2",
    "senha" => "teste"
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  describe "login/2" do
    setup [:create_user]

    test "realiza o login com os dados incorretos", %{conn: conn} do
      conn = post(conn, Routes.login_path(conn, :create), @invalid_params)
      assert json_response(conn, 401) == %{"resultado" => "Nenhum resultado encontrado."}
    end

    test "realiza o login com os dados corretos", %{conn: conn} do
      conn = post(conn, Routes.login_path(conn, :create), @params)
      %{"resultado" => token} = Jason.decode!(conn.resp_body)

      assert {:ok, _} = Phoenix.Token.verify(CalculatorApiWeb.Endpoint, "user auth", token)
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end
