defmodule ExfileImagemagick.Server do
  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :ok)
  end

  def cmd(s, command, args) do
    GenServer.call(s, {:cmd, command, args})
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:cmd, command, args}, _from, state) do
    return = System.cmd(command, args)
    {:reply, return, state}
  end
end
