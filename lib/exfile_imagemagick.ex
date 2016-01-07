defmodule ExfileImagemagick do
  use Application

  @doc false
  def start(_type, _args) do
    Exfile.ProcessorRegistry.register("convert", ExfileImagemagick.Convert)
    Exfile.ProcessorRegistry.register("fill", ExfileImagemagick.Fill)
    Exfile.ProcessorRegistry.register("limit", ExfileImagemagick.Limit)

    {:ok, self}
  end
end
