defmodule ExfileImagemagick.Converter do
  @behaviour Exfile.Processor

  def call(file, []) do
    {:error, :noreason}
  end
end
