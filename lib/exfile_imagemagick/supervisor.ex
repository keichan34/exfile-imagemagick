defmodule ExfileImagemagick.Supervisor do
  use Supervisor

  alias ExfileImagemagick.Server

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    pool_args = [name: {:local, :exfile_imagemagick_processors}, worker_module: Server] ++
      Application.get_env(:exfile_imagemagick, ExfileImagemagick, [size: 6, max_overflow: 1000])
    children = [
      :poolboy.child_spec(:exfile_imagemagick_processors, pool_args, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
