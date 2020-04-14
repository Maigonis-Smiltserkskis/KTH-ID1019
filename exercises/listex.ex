defmodule L do
	def main do
		tak([2, 3, 4, 5, 6])
		drp([2, 3, 4, 5, 6])
	end

	def tak(n) do
		case n do
			[ head | _ ] -> {:ok, head}
			_ -> :no
		end
	end

	def drp(n) do
		case n do
			[ _ | tail] -> {:ok, tail}
			_ -> :no
		end
	end

	def len(l) do
		case l do
			[ _ | tail] -> 1 + len(tail)
			_ -> 0
		end
	end

	def sum(l) do
		case l do
			[ head | tail ] -> head + sum(tail)
			_ -> 0
		end
	end

	def duplicate(l) do
		case l do
			[ head | tail ] -> [2*head | duplicate(tail)]
			[] -> []
		end
	end

	def add(x, l) do
		case l do
			[ head | _ ] when x == head -> []
			[ head | tail ] when x != head -> add(head, tail)
			[] -> []
		end
	end

end
