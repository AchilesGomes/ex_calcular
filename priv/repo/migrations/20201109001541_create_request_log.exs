defmodule CalculatorApi.Repo.Migrations.CreateRequestLog do
  use Ecto.Migration

  def change do
    create table(:request_log) do
      add :method, :string
      add :path, :string
      add :params, :string

      timestamps([:updated_at, false])
    end
  end
end
