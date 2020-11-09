defmodule CalculatorApi.CalculateTest do
  use CalculatorApi.DataCase

  alias CalculatorApi.Calculate

  describe "calculate" do
    test "calculate/1 retorna a soma de uma operação matemática" do
      assert Calculate.calculate("10+10") == 20
    end

    test "calculate/1 retorna a multiplicação de uma operação matemática" do
      assert Calculate.calculate("10*10") == 100
    end

    test "calculate/1 retorna a subtração de uma operação matemática" do
      assert Calculate.calculate("20-10") == 10
    end

    test "calculate/1 retorna a divisão de uma operação matemática" do
      assert Calculate.calculate("30/2") == 15
    end

    test "calculate/1 retorna uma operação matemática com vários operadores" do
      assert Calculate.calculate("(30/2)+15*(10*5)") == 765
    end

    test "calculate/1 retorna error ao usar letra em uma operação matemática" do
      assert Calculate.calculate("(30/2)+15*(10*5)a") == :error
    end
  end
end