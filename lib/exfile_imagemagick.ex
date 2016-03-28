defmodule ExfileImagemagick do
  @moduledoc false

  use Application

  alias Exfile.ProcessorRegistry, as: Registry

  @doc false
  def start(_type, _args) do
    Registry.register("convert", ExfileImagemagick.Convert)
    Registry.register("fill", ExfileImagemagick.Fill)
    Registry.register("limit", ExfileImagemagick.Limit)
    Registry.register("metadata", ExfileImagemagick.Metadata)

    ExfileImagemagick.Supervisor.start_link
  end
end
