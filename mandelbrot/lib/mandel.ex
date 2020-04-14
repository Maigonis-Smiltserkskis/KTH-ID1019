defmodule Mandel do
  def mandelbrot(width, height, x, y ,k ,depth) do
    trans = fn(w, h) ->
      Cmplx.new(x + k * (w - 1), y - k * (h - 1))
    end

    rows(width, height, trans, depth, [])
  end

  def rows(width , height, trans, depth, l) do
    reverse(whole(width , height, trans, depth, l))
  end

  def row(0, _, _, _, l) do l end

  def row(width, height, trans, depth, l) do
    color = Color.convert(Brot.mandelbrot(trans.(width, height), depth), depth)
    row(width - 1, height, trans , depth, [color | l])
  end

  def whole(_, 0, _, _, l) do l end  
  def whole(width, height, trans, depth, l) do
    [row(width, height, trans, depth, l) | whole(width, height - 1, trans, depth, l)]
  end

  def reverse(b) do
    reverse(b, [])
  end

  def reverse([], r) do r end

  def reverse([h|t], r) do
    reverse(t, [h | r])
  end
end
