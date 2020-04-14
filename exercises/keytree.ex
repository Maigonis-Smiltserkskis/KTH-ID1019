defmodule K do 
  def lookup(_ , :nil) do :no end
  def lookup(key, {:node, key, value, _, _}) do {:ok, value} end
  def lookup(key, {:node, key, value, :nil, _}) do {:ok, value} end
  def lookup(key, {:node, key, value, _, :nil}) do {:ok, value} end
  def lookup(key, {:node , diffkey, _, left, _}) when key < diffkey do
    lookup(key, left)
  end
  def lookup(key, {:node, _, _, _, right}) do
    lookup(key, right)
  end 

  def add(key, value, :nil) do {:node, key, value, :nil, :nil} end
  def add(key, value, {:node, diffkey, diffvalue, :nil, :nil}) when key < diffkey do {:node, diffkey, diffvalue, {:node, key, value, :nil, :nil}, :nil} end
  def add(key, value, {:node, diffkey, diffvalue, :nil, :nil}) do {:node, diffkey, diffvalue, :nil, {:node, key, value, :nil, :nil}} end
  def add(key, value, {:node, diffkey, diffvalue, left, right}) when key < diffkey do
    {:node, diffkey, diffvalue, add(key, value, left), right}
  end
  def add(key, value, {:node, diffkey, diffvalue, left, right}) do
    {:node, diffkey, diffvalue, left, add(key, value, right)}
  end

  def remove(key, {:node, key, _, :nil, :nil}) do :nil end
  def remove(key, {:node, key, _, left, :nil}) do left end
  def remove(key, {:node, key, _, :nil, right}) do right end
  def remove(key, {:node, key, _, left, right}) do
    {x, y} = rightmost(left)
    {:node, x, y, remove(x, left), right}    
  end
  def remove(key, {:node, diffkey, diffvalue, left, right})when key < diffkey do
    {:node, diffkey, diffvalue, remove(key, left), right}
  end

  def remove(key, {:node, diffkey, diffvalue, left, right}) do
    {:node, diffkey, diffvalue, left, remove(key, right)}
  end

  def rightmost({:node, key, value, :nil, :nil}) do {key, value} end
  def rightmost({:node, _, _, _, right}) do
    rightmost(right)
  end

  

end
