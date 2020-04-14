defmodule C do
  #calculator
  def eval({:int, n}) do n end
  def eval({:add, a, b}) do
    eval(a) + eval(b)
  end
  def eval({:sub, a, b}) do
    eval(a) - eval(b)
  end
  def eval({:mul, a, b}) do
    eval(a) * eval(b)
  end
  
  #list lookup for value of bindings based on name
  def lookup(name, [{:bind, name , value} | _])do value end
  def lookup(name, [_ | rest]) do lookup(name, rest) end
  
  #calculator using bindings and atoms as variable names
  def evalvar({:var, name}, bindings) do
    lookup(name, bindings)
  end
  def evalvar({:add , a, b}, bindings) do
    evalvar(a, bindings) + evalvar(b, bindings)
  end
  def evalvar({:sub , a, b}, bindings) do
    evalvar(a, bindings) - evalvar(b, bindings)
  end
  def evalvar({:mul , a, b}, bindings) do
    evalvar(a, bindings) * evalvar(b, bindings)
  end

end
