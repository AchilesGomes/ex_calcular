defmodule CalculatorApi.Repo do
  use Ecto.Repo,
    otp_app: :calculator_api,
    adapter: Ecto.Adapters.Postgres
end
