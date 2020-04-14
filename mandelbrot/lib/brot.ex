defmodule Brot do
  def mandelbrot(c, m) do

    z0 = Cmplx.new(0,0)
    i = 0
    test(i, z0, c, m)

  end

  def test(i, z0, c, m) do
    cond do
      Cmplx.abs(z0) > 2 ->
      i
      i == m ->
      0
      true ->
      z = Cmplx.add(Cmplx.sqr(z0), c)
      i = i + 1
      test(i, z, c, m)
    end
  end
end
