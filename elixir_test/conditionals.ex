defmodule M do
    def main do
        do_thing()
    end

    def do_thing do
        age = 16

        if age >= 18 do
            IO.puts "Can vote"
        else
            IO.puts "Can't vote"
        end

        unless age === 18 do
            IO.puts "You are not 18"
        else
            IO.puts "You are 18"
        end

        cond do
            age >= 18 -> IO.puts "You can vote"
            age >= 16 -> IO.puts "You can drive"
            age >= 14 -> IO.puts "You can wait"

            true -> IO.puts "Default"
        end

        case 2 do
            1 -> IO.puts "Entered 1"
            2 -> IO.puts "Entered 2"
            _ -> IO.puts "Default"
                
        end

        IO.puts "Ternary : #{if age > 18, do: "Can Vote", else: "Cant vote"}"


    end
end