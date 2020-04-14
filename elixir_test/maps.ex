defmodule M do
    def main do
        stuff()
    end

    def stuff do
        capitals = %{"Latvia" => "Riga",
        "Lithuania" => "Vilnius", "Estonia" => "Tallin" }

        IO.puts "Captial of Latvia is #{capitals["Latvia"]}"

        capitals2 = %{latvia: "Riga",
        lithuania: "Vilnius", estonia: "Tallin" }

        IO.puts "Captial of Lithuania #{capitals2.lithuania}"

        capitals3 = Dict.put_new(capitals, "Germany" , "Berlin")


    end
end