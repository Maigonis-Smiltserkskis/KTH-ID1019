defmodule M do
    def main do
        thing()
    end

    def thing do
        list1 = [1, 2, 3]
        list2 = [4, 5, 6]

        list3 = list1 ++ list2

        list4 = list3 -- list1

        IO.puts 6 in list4

        [head | tail] = list3   #head - first item in list, tail - rest of items

        IO.puts "Head : #{head}"

        IO.write "Tail : "
        IO.inspect tail                                 #inspect prints internal representation 

        IO.inspect [97, 98], charlists: :as_lists 

        Enum.each tail, fn item ->
            IO.puts item
        end

        words = ["Random", "Words", "in a", "list"]

        Enum.each words, fn word ->                     #enumerates through list
            IO.puts word
        end

        display_list(words)

        IO.puts display_list(List.delete(words, "Random"))

        IO.puts display_list(List.delete_at(words, 1))

        IO.puts display_list(List.insert_at(words, 4, "YE"))

        IO.puts List.first(words)

        IO.puts List.last(words)

        my_stats = [name: "Rudolfs", height: 180]       #list of key value tuples
    end

    def display_list([word | words]) do
        IO.puts word
        display_list(words)
    end

    def display_list([]), do: nil
end
