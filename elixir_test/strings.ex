defmodule M do
    def main do
        do_stuff()
    end

    def do_stuff do
        my_str = "Mans teikums"
        IO.puts "Length: #{String.length(my_str)}"
        longer_str = my_str <> " " <> "ir garaks"   # string concatination "<>"
        IO.puts "Equal: #{"Leg" === "leg"}"         # "===" equal value AND datatype
        IO.puts "Mans ? #{String.contains?(my_str, "Mans")}"

        IO.puts "First: #{String.first(my_str)}"    # first string char

        IO.puts "Index 5: #{String.at(my_str, 5)}"  

        IO.puts "Substring: #{String.slice(my_str, 3, 7)}"

        IO.inspect String.split(longer_str, " ")    #split string in to list spliting by whitespice " "

        IO.puts String.reverse(longer_str)          #reverse string
        IO.puts String.upcase(longer_str)           
        IO.puts String.downcase(longer_str)
        IO.puts String.capitalize(longer_str)      #Capitalize first word

        4 * 10 |> IO.puts
    end

    
end