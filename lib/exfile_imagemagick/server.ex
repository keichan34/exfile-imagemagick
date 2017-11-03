defmodule ExfileImagemagick.Server do
  use GenServer

  @image_processor Application.get_env(:exfile_imagemagick, :image_processor, :imagemagick)

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :ok)
  end

  def cmd(s, command, args) do
    case @image_processor do
      :graphicsmagick -> GenServer.call(s, {:cmd, "GM", [command] ++ args})
      _ -> GenServer.call(s, {:cmd, command, args})
    end
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:cmd, command, args}, _from, state) do
    return = System.cmd(command, args)
    {:reply, return, state}
  end
end
