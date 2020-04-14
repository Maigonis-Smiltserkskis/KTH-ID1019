defmodule M do
    def main do
        do_stuff()
    end

    def do_stuff do
        IO.puts "5 + 4 = #{5+4}"
        IO.puts "5 - 4 = #{5-4}"
        IO.puts "5 * 4 = #{5*4}"
        IO.puts "5 / 4 = #{5/4}"
        IO.puts "5 div 4 = #{div(5,4)}"     #integer divison, removes decimals
        IO.puts "5 rem 4 = #{rem(5,4)}"     #remainder (mod)
    end
end

#5 + 4 = 9
#5 - 4 = 1
#5 * 4 = 20
#5 / 4 = 1.25
#5 div 4 = 1
#5 rem 4 = 1