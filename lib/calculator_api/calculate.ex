defmodule CalculatorApi.Calculate do
  @moduledoc """
  The Calculate context.
  """

  @doc """
  Returns the result of a compute.

  ## Examples

      iex> CalculatorApi.Calculate.calculate("80*10")
      800

  """
  @spec calculate(String.t()) :: integer() | float() | :error
  def calculate(param) do
    param
    |> validate
    |> case do
      false ->
        param
        |> Code.eval_string()
        |> elem(0)
      true ->
        :error
    end    
  end

  @spec validate(String.t()) :: boolean()
  def validate(param) do
    result = String.match?(param, ~r/[[:alpha:]]/)
    result
  end
end
