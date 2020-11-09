defmodule CalculatorApiWeb.CalculateControllerTest do
  use CalculatorApiWeb.ConnCase

  alias CalculatorApi.Calculate

  @token "SFMyNTY.g2gDYQZuBgCjdE6qdQFiAAFRgA.b9f4fTc_hns55J4_vNVYw4iy3vDmSFCyHdkTaZPE0rA"
  @params "(10*10)+(20/5)*(5*1.5)"
  @invalid_params "(10*10)+(20/5)*(5*1.5)A"

  def fixture(:calculo) do
    calculo = Calculate.calculate(@params)
    calculo
  end  

  setup %{conn: conn} do
    {
      :ok,
      conn:
        conn
        |> put_req_header("accept", "application/json")
        |> put_req_header("authorization", @token)
    }
  end

  describe "calculate/1" do
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
