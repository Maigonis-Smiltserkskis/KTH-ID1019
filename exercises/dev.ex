defmodule D do

  def test(x), do: IO.puts(inspect(x))

  def derivative(n) when is_number(n) do 0 end

  def derivative(n) when is_atom(n) do 1 end

  @type literal() :: {:const, number()}
                  | {:const, atom()}
                  | {:var, atom()}
  
  @type expr() :: {:add, expr(), expr()}
              | {:mul, expr(), expr()}
              | literal()

  
  def deriv({:const, _}, _) do
    0
  end

  def deriv({:var, v}, v) do
    1
  end
  
  def deriv({:var, y}, _) do 1 end
  
  def deriv({:mul, e1 , e2}, v) do derivative(e1) * e2 + e1 * derivative(e2) end 
  
  def deriv({:add, e1, e2}, v) do derivative(e1) + derivative(e2) end

end
