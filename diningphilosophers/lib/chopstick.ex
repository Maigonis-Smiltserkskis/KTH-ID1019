defmodule Chopstick do

  def start do
    spawn_link(fn() -> available() end)
  end

  def available() do
    receive do
      {:request, from} ->
        send(from, {:granted, self()})
        gone()
      :quit ->
        :ok
    end
  end

  def gone() do
    receive do
      {:return, from} ->
        send(from, :returned)
        available()
      :quit -> :ok
    end
  end

  def request(stick, timeout) do
    send(stick, {:request, self()})
    receive do
      {:granted, _} ->
        :ok
    after timeout ->
        :no
    end
  end

  #Process.alive?(pid) to check if process died
  def quit(stick) do
    send(stick, :quit)
  end

  def return(stick) do
    send(stick, {:return, self()})
    receive do
      :returned -> :ok
    end
  end

end
