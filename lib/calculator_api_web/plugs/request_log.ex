defmodule CalculatorApiWeb.Plugs.RequestLog do
  @moduledoc false

  require Logger

  alias Plug.Conn
  alias CalculatorApi.Repo
  alias CalculatorApi.Log.RequestLog

  def init(default), do: default

  def call(conn, _) do
    Conn.register_before_send(conn, fn conn ->
      log =
        %{}
        |> Map.put(:method, conn.method)
        |> Map.put(:path, conn.request_path)
        |> Map.put(:params, resp_body(conn))
      
      %RequestLog{}
      |> RequestLog.changeset(log)
      |> Repo.insert()
      |> case do
        {_integer, nil} -> conn

        _ ->
          conn
      end      
    end)
  end

  defp resp_body(%Plug.Conn{body_params: params}) when params === %{}, do: ""
  defp resp_body(conn), do: conn.body_params["calculo"]
end
