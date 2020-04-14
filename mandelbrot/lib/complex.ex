defmodule Cmplx do
  def new(r, i) do
    {r, i}
  end

  def add(a, b) do
    {x1, y1} = a
    {x2, y2} = b
    {x1 + x2, y1 + y2}
  end

  def sqr(a) do
    {x, y} = a
    {x*x - y*y, 2 * x *y}
  end

  def abs(a) do
    {x, y} = a
    :math.sqrt(x * x + y * y)
  end
end
