defmodule ExfileImagemagick do
  use Application

  @doc false
  def start(_type, _args) do
    Exfile.ProcessorRegistry.register("convert", ExfileImagemagick.Convert)
    Exfile.ProcessorRegistry.register("fill", ExfileImagemagick.Fill)

    {:ok, self}
  end
end
