defmodule CalculatorApiWeb.Plugs.Auth do
  @moduledoc false

  import Plug.Conn

  alias Phoenix.Token
  alias CalculatorApiWeb.Endpoint

  def init(default), do: default

  def call(conn, _opts) do
    with  [token]        <- get_req_header(conn, "authorization"),
          {:ok, usuario} <- Token.verify(Endpoint, "user auth", token),
          :ok            <- :ok do
      token = Token.sign(Endpoint, "user auth", usuario)

      conn
      |> assign(:usuario, usuario)
      |> put_resp_header("authorization", token)
    else
      {:error, :invalid} ->
        conn
        |> resp(:unauthorized, Jason.encode!(%{success: false, message: "token inválido."}))
        |> halt
    end    
  end
end