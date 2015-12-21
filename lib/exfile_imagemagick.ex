defmodule ExfileImagemagick do
  use Application

  @doc false
  def start(_type, _args) do
    Exfile.ProcessorRegistry.register("convert", ExfileImagemagick.Converter)
    {:ok, self}
  end
end
