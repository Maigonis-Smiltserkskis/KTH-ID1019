defmodule Rudy do

  @nofHandlers 10

  def start(port) do
    Process.register(spawn(fn -> init(port) end), :rudy)
  end

  def stop() do
    Process.exit(Process.whereis(:rudy), "keel over and die :^(")
  end

  def init(port) do
    opt = [:list, active: false, reuseaddr: true, backlog: 1000]

    case :gen_tcp.listen(port, opt) do
      {:ok, listen} ->
        handlers(@nofHandlers, listen)
        :gen_tcp.close(listen)
        :ok
      {:error, error} ->
        error
    end
  end

  def overlook(listen) do
    receive do
      {:EXIT, _pid, reason} ->
        IO.puts("reason")
        spawn_link(fn() -> handler(listen) end)
        overlook(listen)
      strange ->
        IO.puts("Strange message #{strange}")
        overlook(listen)
    end
  end

  def handlers(0, listen) do
    overlook(listen)
  end

  def handlers(n, listen) do
    spawn_link(fn() -> handler(listen) end)
    handlers(n - 1, listen)
  end

  def handler(listen) do
    case :gen_tcp.accept(listen) do
      {:ok, client} ->
        request(client)
        :gen_tcp.close(client)
        handler(listen)
      {:error, error} ->
        error
    end
  end

  def request(client) do
    recv = :gen_tcp.recv(client, 0)
    case recv do
      {:ok, str} ->
        parsed = HTTP.parse_request(str)
        response = reply(parsed)
        :gen_tcp.send(client, response)
      {:error, error} ->
        IO.puts("RUDY ERROR: #{error}")
    end
    :gen_tcp.close(client)
  end

  def reply({{:get, uri, _}, _, _}) do
    :timer.sleep(10)
    HTTP.ok("Hello!")
  end

end
