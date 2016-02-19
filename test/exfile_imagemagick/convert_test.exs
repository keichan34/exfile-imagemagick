defmodule ExfileImagemagick.ConvertTest do
  use ExUnit.Case, async: true

  alias Exfile.LocalFile

  test "it works" do
    path = EITH.image_path("DSC08511s25.jpg")
    file = %LocalFile{path: path}
    {:ok, file} = ExfileImagemagick.Convert.call(file, ["png"], [])
    {:ok, file} = ExfileImagemagick.Metadata.call(file, [], [])

    assert file.meta["format"] == "PNG"
    assert file.meta["image_size"] == "1148x764"
  end

  test "it won't convert a file if it is already in the requested format" do
    path = EITH.image_path("DSC08511s25.jpg")
    orig_file = %LocalFile{path: path}
    {:ok, converted_file} = ExfileImagemagick.Convert.call(orig_file, ["jpeg"], [])

    {:ok, meta_file} = ExfileImagemagick.Metadata.call(converted_file, [], [])

    assert meta_file.meta["format"] == "JPEG"
    assert meta_file.meta["image_size"] == "1148x764"
    assert orig_file == converted_file
  end
end
