defmodule ExfileImagemagickTest do
  use ExUnit.Case

  alias Exfile.ProcessorRegistry, as: Registry

  test "ExfileImagemagick.Convert is loaded as `convert`" do
    assert \
      {:ok, ExfileImagemagick.Convert}
      ==
      Registry.get_processor_module("convert")
  end

  test "ExfileImagemagick.Fill is loaded as `fill`" do
    assert \
      {:ok, ExfileImagemagick.Fill}
      ==
      Registry.get_processor_module("fill")
  end

  test "ExfileImagemagick.Limit is loaded as `limit`" do
    assert \
      {:ok, ExfileImagemagick.Limit}
      ==
      Registry.get_processor_module("limit")
  end

  test "ExfileImagemagick.Metadata is loaded as `metadata`" do
    assert \
      {:ok, ExfileImagemagick.Metadata}
      ==
      Registry.get_processor_module("metadata")
  end
end
