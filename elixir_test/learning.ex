defmodule M do
    def main do
        name = IO.gets("What is your name? ") |> String.trim
        IO.puts "Hello #{name}"
        data_stuff()
    end

    def data_stuff do
        xint = 123
        my_float = 2.272
        IO.puts "Integer: #{is_integer(xint)}"
        IO.puts "Float: #{is_float(my_float)}"
        IO.puts "Atom: #{is_atom(:Riga)}"
        :"Liepaja"

        one2ten = 1..10; #range 1 2 3 4 5 6 7 8 9 10

    end





end
