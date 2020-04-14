defmodule E do
  def double(n) do
    n * 2
  end

  def prof(m, n) do
    case m do
      0 -> 0
      _ -> n + prof(m - 1, n)
    end
  end

  def fib(n) do
    case n do
      0 -> 0
      1 -> 1
      n -> fib(n - 1) + fib(n - 2)
    end
  end

  def ack(m,n) do
    case {m, n} do
      {0, n} -> n + 1
      {m, 0} when m > 0 -> ack(m - 1, 1)
      _ -> ack(m - 1, ack(m, n - 1))
    end
  end


end
