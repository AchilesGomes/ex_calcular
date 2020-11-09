defmodule CalculatorApiWeb.UserController do
  use CalculatorApiWeb, :controller
  use PhoenixSwagger

  alias CalculatorApi.Accounts
  alias CalculatorApi.Accounts.User

  action_fallback CalculatorApiWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def swagger_definitions do
    %{
      User: swagger_schema do
        title "Accounts"
        description "A user of the application"
        properties do
          login :string, "Users name", required: true
          password :string, "password"
        end
        example %CalculatorApi.Accounts.User{
          login: "Joe",
          password: "teste",
        }
      end,
      Users: swagger_schema do
        title "Accounts"
        description "A collection of accounts"
        type :array
        items Schema.ref(:User)
      end
    }
  end
end
