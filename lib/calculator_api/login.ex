defmodule CalculatorApi.Login do
  @moduledoc """
  The Login context.
  """

  import Ecto.Query, warn: false

  alias Phoenix.Token
  alias CalculatorApi.Repo
  alias CalculatorApi.Accounts.User
  alias CalculatorApiWeb.Endpoint

  @doc """
  Returns user by login if success.

  ## Examples

      iex> CalculatorApi.Login.get_user!("teste")
      %CalculatorApi.Accounts.User{
        __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
        id: 7,
        inserted_at: ~N[2020-11-08 23:02:09],
        level: 1,
        login: "teste",
        password: "teste",
        updated_at: ~N[2020-11-08 23:02:09]
      }
  """
  @spec get_user!(String.t()) :: {:error, String.t()} | any()
  def get_user!(login) do
    User
    |> Repo.get_by([login: login])
    |> case do
      nil     -> {:error, "Nenhum resultado encontrado."}
      result  -> IO.inspect(result)
    end
  end

  @doc """
  Validate the password if exists and right.

  ## Examples

      iex> CalculatorApi.Login.validate_password(%User{}, param)
      {:ok,
      %{
        __meta__: #Ecto.Schema.Metadata<:built, "users">,
        __struct__: CalculatorApi.Accounts.User,
        id: 7,
        inserted_at: ~N[2020-11-08 23:02:09],
        level: 1,
        login: "teste",
        password: "teste",
        token: "SFMyNTY.g2gDYQduBgA0Pi-rdQFiAAFRgA.4jcDXwHlxFtIff4dNpQhLrT4e_IBmJD-NEIjxSaqvnE",
        updated_at: ~N[2020-11-08 23:02:09]
      }}

      iex> CalculatorApi.Login.validate_password(%User{}, wrong_param)
      {:error, :user_or_password_wrong}
  """
  @spec validate_password({:error, String.t()}, none()) :: {:error, String.t()}
  def validate_password({:error, message}, _), do: {:error, message}

  @spec validate_password(struct(), String.t()) :: {:ok, String.t()} | {:error, :user_or_password_wrong}
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