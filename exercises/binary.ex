defmodule B do

  def append([], y) do y end
  def append([h | t], y) do
    [h | append(t, y)]
  end

######################dec_to_binary#########################

  def to_binary(0) do [0] end
  def to_binary(1) do [1] end
  def to_binary(n) do 
    append(to_binary(div(n,2)), [rem(n,2)])
  end

  def to_better(n) do to_better(n, []) end

  def to_better(0, b) do b end

  def to_better(n, b) do
    to_better(div(n, 2) , [rem(n,2) | b])
  end

#####################bin_to_dec#############################

  def to_integer(x) do to_integer(x, 0)end

  def to_integer([], n) do n end

  def to_integer([x | r], n) do
    to_integer(r, 2 * n + x)
  end

end
