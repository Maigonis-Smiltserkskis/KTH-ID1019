defmodule Philosopher do
  def sleep(0) do :ok end
  def sleep(t) do
    :timer.sleep(:rand.uniform(t))
  end

  def eat(t) do :timer.sleep(t) end

  def start(hunger, right, left, name, ctrl) do
    spawn_link(fn() -> dreaming(hunger, right, left ,name ,ctrl) end)
  end

  def dreaming(0, _, _, name, ctrl) do
    send(ctrl, :done)
    IO.puts("#{name} is done")
  end
  def dreaming(hunger, left, right, name, ctrl) do
    IO.puts("#{name} is dreaming")
    sleep(10)
    waiting(hunger, left, right, name, ctrl)
  end

  def eating(hunger, left, right, name, ctrl) do
    eat(hunger)
    IO.puts("#{name} has eaten (remaining hunger: #{hunger - 1})")
    Chopstick.return(left)
    Chopstick.return(right)
    dreaming(hunger - 1, left, right, name, ctrl)
  end

  def waiting(hunger, left, right, name, ctrl) do
    timeout = :rand.uniform(hunger * 100)
    IO.puts("#{name} is waiting")
    case Chopstick.request(left, timeout) do
      :ok ->
        IO.puts("#{name} received a chopstick")
        case Chopstick.request(right, timeout) do
          :ok ->
            IO.puts("#{name} received another chopstick")
            eating(hunger, left, right, name, ctrl)
          :no ->
            Chopstick.return(left)
            Chopstick.return(right)
            IO.puts("#{name} waited for #{timeout} ms for 2nd stick and gave up")
            dreaming(hunger, left, right, name ,ctrl)
        end
    end
  end

end
