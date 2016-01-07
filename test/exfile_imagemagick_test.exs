defmodule ExfileImagemagickTest do
  use ExUnit.Case

  test "ExfileImagemagick.Convert is loaded as `convert`" do
    assert \
      {:ok, ExfileImagemagick.Convert}
      ==
      Exfile.ProcessorRegistry.get_processor_module("convert")
  end

  test "ExfileImagemagick.Fill is loaded as `fill`" do
    assert \
      {:ok, ExfileImagemagick.Fill}
      ==
      Exfile.ProcessorRegistry.get_processor_module("fill")
  end

  test "ExfileImagemagick.Limit is loaded as `limit`" do
    assert \
      {:ok, ExfileImagemagick.Limit}
      ==
      Exfile.ProcessorRegistry.get_processor_module("limit")
  end
end
