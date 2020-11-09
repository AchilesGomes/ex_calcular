defmodule CalculatorApiWeb.CalculateControllerTest do
  use CalculatorApiWeb.ConnCase

  alias CalculatorApi.Calculate

  @params "(10*10)+(20/5)*(5*1.5)"
  @invalid_params "(10*10)+(20/5)*(5*1.5)A"

  def fixture(:calculo) do
    calculo = Calculate.calculate(@params)
    calculo
  end  

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "calculate" do
    test "realiza o cálculo de uma operação matemática", %{conn: conn} do
      conn = post(conn, Routes.calculate_path(conn, :index), calculo: @params)
      assert json_response(conn, 201)["resultado"] == 130
    end

    test "não realiza o cálculo de uma operação matemática caso possua uma letra", %{conn: conn} do
      conn = post(conn, Routes.calculate_path(conn, :index), calculo: @invalid_params)
      assert json_response(conn, 200)["retorno"] == "Não utilizei letras no cálculo"
    end
  end
end
