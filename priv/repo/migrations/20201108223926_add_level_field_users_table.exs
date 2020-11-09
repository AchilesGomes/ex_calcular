defmodule CalculatorApi.Repo.Migrations.AddLevelFieldUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :level, :integer, default: 1
    end
  end
end
