defmodule Color do
  def convert(depth, max) do
    x = trunc(4 * (depth / max))
    y = trunc(255 * (4 * (depth / max) - x))
    case x do
      0 ->
        {:rgb, y, 0 ,0}
      1 ->
        {:rgb, 255, y, 0}
      2 ->
        {:rgb, 255 - y, 255, 0}
      3 ->
        {:rgb, 0, 255, y}
      4 ->
        {:rgb, 0, 255 - y, 255}
    end
  end
end
