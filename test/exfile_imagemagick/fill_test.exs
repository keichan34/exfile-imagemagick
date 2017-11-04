defmodule ExfileImagemagick.FillTest do
  use ExUnit.Case, async: true

  alias Exfile.LocalFile

  test "it works" do
    path = EITH.image_path("DSC08511s25.jpg")
    file = %LocalFile{path: path}
    {:ok, file} = ExfileImagemagick.Fill.call(file, ["100", "100"], [])
    {:ok, file} = ExfileImagemagick.Metadata.call(file, [], [])

    assert file.meta["format"] == "JPEG"
    assert file.meta["image_size"] == "100x100"
    assert file.meta["DateTimeOriginal"] == "2012:08:27 08:17:02"
  end

  test "it works with the :format option" do
    path = EITH.image_path("DSC08511s25.jpg")
    file = %LocalFile{path: path}
    {:ok, file} = ExfileImagemagick.Fill.call(file, ["100", "100"], [format: "png"])
    {:ok, file} = ExfileImagemagick.Metadata.call(file, [], [])

    assert file.meta["format"] == "PNG"
    assert file.meta["image_size"] == "100x100"
  end
end
