defmodule CalculatorApiWeb.AuthTest do
  use CalculatorApiWeb.ConnCase

  @token "SFMyNTY.g2gDYQZuBgCjdE6qdQFiAAFRgA.b9f4fTc_hns55J4_vNVYw4iy3vDmSFCyHdkTaZPE0rA"
  @invalid_token "SFMyNTY.g2gDYQZuBgCjdE6qdQFiAAFRgA.b9f4fTc_hns55J4_vNVYw4iy3vDmSFCyHdkTaZPE0r"
  @params "(10*10)+(20/5)*(5*1.5)"

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "auth plug" do
    test "requisição com token válido", %{conn: conn} do
      conn =
        conn
        |> put_req_header("authorization", @token)
        |> post(Routes.calculate_path(conn, :index), calculo: @params)

      assert json_response(conn, 201)["resultado"] == 130
    end

    test "requisição com token inválido", %{conn: conn} do
      conn =
        conn
        |> put_resp_content_type("application/json")
        |> put_req_header("authorization", @invalid_token)
        |> post(Routes.calculate_path(conn, :index), calculo: @params)

      assert json_response(conn, 401) == %{"message" => "token inválido.", "success" => false}
    end
  end
end