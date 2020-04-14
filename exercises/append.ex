defmodule L do
  def append([], y) do y end
  def append([h | t], y) do
    [h | append(t, y)]
  end
end
