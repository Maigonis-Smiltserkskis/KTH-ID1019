defmodule M do
    def main do
        do_this()
    end

    #*************TUPLE = FIXED SIZE LIST BASICALLY*****************
    def do_this do
        my_stats = {175, 6.25, :Janis}

        IO.puts "Tuple #{is_tuple(my_stats)}"

        my_stats2 =  Tuple.append(my_stats, 42)     #when adding to tuple, need to create new tuple

        IO.puts "Age #{elem(my_stats2, 3)}"         #prints specified element of tuple

        IO.puts "Size : #{tuple_size(my_stats2)}"   #prints nof elements in tuple

        my_stats3 = Tuple.delete_at(my_stats2, 0)   #deleting elements from tuple, need to rewrite again
        my_stats4 = Tuple.insert_at(my_stats3, 0, 1990) #inserteing element, need to rewrite

        many_zeroes = Tuple.duplicate(0, 5)         #{0, 0, 0, 0, 0}

        {weight, height, name} = {175, 6.25, "Janis"}

        IO.puts "Weight : #{weight}"
    end
end