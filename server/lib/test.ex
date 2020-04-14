defmodule Test do
  @number_requests 100

  def bench(host, port) do
    start = Time.utc_now()
    run(@number_requests, host, port)
    finish = Time.utc_now()
    diff = Time.diff(finish, start, :millisecond)
    IO.puts("Benchmark: #{@number_requests} requests in #{diff} ms")
  end

  defp run(0, _host, _post), do: :ok
  defp run(n, host, port) do
    request(host, port)
    run(n - 1, host, port)
  end

  defp request(host, port) do
    opt = [:list, active: false, reuseaddr: true]
    {:ok , server} = :gen_tcp.connect(host, port, opt)
    :gen_tcp.send(server, HTTP.get("foo"))
    {:ok, _reply} = :gen_tcp.recv(server, 0)
    :gen_tcp.close(server)
  end

end

defmodule TestConc do

  @number_requests 100

  def bench(host, port) do
    start = Time.utc_now()
    es = self()
    run(@number_requests, host, port, es)
    finish = Time.utc_now()
    diff = Time.diff(finish, start, :millisecond)
    IO.puts("Benchmark: #{@number_requests} requests in #{diff} ms")
  end

  defp run(0, _host, _port, _es), do: wait(0)
  defp run(n, host, port, es) do
    spawn_link(fn() -> request(host, port, es) end)
    run(n - 1, host, port, es)
  end

  def wait(@number_requests), do: :ok
  def wait(n) do
    receive do
      {:ok, _reply} ->
        wait(n + 1)
    end
  end


  defp request(host, port, es) do
    opt = [:list, active: false, reuseaddr: true]
    {:ok , server} = :gen_tcp.connect(host, port, opt)
    :gen_tcp.send(server, HTTP.get("foo"))
    {:ok, reply} = :gen_tcp.recv(server, 0)
    :gen_tcp.close(server)
    send(es, {:ok, reply})
  end

end
