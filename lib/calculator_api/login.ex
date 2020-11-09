defmodule CalculatorApi.Login do
  @moduledoc """
  The Login context.
  """

  import Ecto.Query, warn: false

  alias Phoenix.Token
  alias CalculatorApi.Repo
  alias CalculatorApi.Accounts.User
  alias CalculatorApiWeb.Endpoint

  def get_user!(login) do
    User
    |> Repo.get_by([login: login])
    |> case do
      nil     -> {:error, "Nenhum resultado encontrado."}
      result  -> result 
    end
  end

  def validate_password({:error, message}, _), do: {:error, message}
  def validate_password(%User{password: password} = usuario, param) do
    password
    |> Kernel.===(param)
    |> case do
      true ->
        generate_token(usuario)
      false ->
        {:error, :user_or_password_wrong}
    end
  end

  @spec generate_token(map()) :: {:ok, map()}
  defp generate_token(usuario) do
    {:ok, usuario |> Map.put(:token, Token.sign(Endpoint, "user auth", usuario.id))}
  end
end