defmodule M do

  def add(x, []) do [x] end
  def add(x, [h | t]) do
    case x do
      x when x == h -> [h | t]
      _ -> [h | add(x, t)]
    end
  end

  def remove(_, []) do [] end
  def remove(n, [h | t]) do
    case n do
      n when n == h -> remove(n, t)
      _ -> [h | remove(n, t)]
    end
  end

  def unique([]) do [] end
  def unique([h | t]) do
    add(h, unique(remove(h, t)))
  end

  def reverse(l) do
    reverse(l, [])
  end

  def reverse([], r) do r end
  def reverse([h | t], r) do
    reverse(t, [h | r])
  end

end
