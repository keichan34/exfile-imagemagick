defmodule ExfileImagemagickTest do
  use ExUnit.Case

  test "ExfileImagemagick.Converter is loaded as `convert`" do
    assert \
      {:ok, ExfileImagemagick.Converter}
      ==
      Exfile.ProcessorRegistry.get_processor_module("convert")
  end
end
