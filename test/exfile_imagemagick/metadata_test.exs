defmodule ExfileImagemagick.MetadataTest do
  use ExUnit.Case, async: true

  alias Exfile.LocalFile

  test "it works" do
    path = EITH.image_path("DSC08511s25.jpg")
    file = %LocalFile{path: path}
    {:ok, file} = ExfileImagemagick.Metadata.call(file, [], [])
    assert file.meta["format"] == "JPEG"
    assert file.meta["image_size"] == "1148x764"
    assert file.meta["DateTimeOriginal"] == "2012:08:27 08:17:02"
  end

  test "it works with an IO-based LocalFile" do
    path = EITH.image_path("DSC08511s25.jpg")
    file = %LocalFile{path: path}
    {:ok, io} = LocalFile.open(file)

    io_file = %LocalFile{io: io}
    {:ok, io_file} = ExfileImagemagick.Metadata.call(io_file, [], [])

    assert io_file.meta["format"] == "JPEG"
    assert io_file.meta["image_size"] == "1148x764"
    assert io_file.meta["DateTimeOriginal"] == "2012:08:27 08:17:02"
  end

  test "non existant meta data yield nil" do
    path = EITH.image_path("empty.png")
    file = %LocalFile{path: path}
    {:ok, io} = LocalFile.open(file)

    io_file = %LocalFile{io: io}
    {:ok, io_file} = ExfileImagemagick.Metadata.call(io_file, [], [])
    assert io_file.meta["format"] == "PNG"
    assert io_file.meta["image_size"] == "1x1"
    assert io_file.meta["DateTimeOriginal"] == nil
  end

  test "it fails on a nonexistant file" do
    path = EITH.image_path("nonexistant.jpg")
    file = %LocalFile{path: path}
    assert {:error, :ident_error} = ExfileImagemagick.Metadata.call(file, [], [])
  end
end
