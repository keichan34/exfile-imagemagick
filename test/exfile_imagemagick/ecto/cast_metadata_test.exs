defmodule Exfile.Ecto.CastContentTypeTest do
  use ExUnit.Case, async: true

  import Ecto.Changeset, only: [cast: 4]
  import ExfileImagemagick.Ecto.CastMetadata

  test "assigns EXIF DateTimeOriginal and ExposureTime correctly" do
    changeset = Ecto.Changeset.cast(initial_changeset(), %{ image: image_file() }, [:image], [])
      |> cast_metadata(:image, "DateTimeOriginal")
      |> cast_metadata(:image, "ExposureTime")

    assert changeset.changes[:image_date_time_original] == "2012:08:27 08:17:02"
    assert changeset.changes[:image_exposure_time] == "1/400"
  end

  test "assigns EXIF DateTimeOriginal and ExposureTime to custom fields" do
    changeset = Ecto.Changeset.cast(initial_changeset(), %{ image: image_file() }, [:image], [])
      |> cast_metadata(:image, "DateTimeOriginal", :field1)
      |> cast_metadata(:image, "ExposureTime", :field2)

    assert changeset.changes[:field1] == "2012:08:27 08:17:02"
    assert changeset.changes[:field2] == "1/400"
  end

  test "assigns EXIF DateTimeOriginal and ExposureTime to custom fields with custom value formats" do
    changeset = Ecto.Changeset.cast(initial_changeset(), %{ image: image_file() }, [:image], [])
      |> cast_metadata(:image, "DateTimeOriginal", field1: :naive_datetime)
      |> cast_metadata(:image, "ExposureTime", field2: :string)
      |> cast_metadata(:image, "MeteringMode", field3: :integer)

    assert changeset.changes[:field1] == ~N[2012-08-27 08:17:02]
    assert changeset.changes[:field2] == "1/400"
    assert changeset.changes[:field3] == 5
  end

  test "doesn't assign anything if file is not present in changeset" do
    changeset = cast(initial_changeset(), %{ image: nil }, [:image], [])
    |> cast_metadata(:image, "DateTimeOriginal")
    |> cast_metadata(:image, "ExposureTime")

    assert changeset.changes[:image_date_time_original] == nil
    assert changeset.changes[:image_exposure_time] == nil
  end


  defp initial_changeset() do
    data  = %{
      image: nil,
      image_date_time_original: nil,
      image_exposure_time: nil
    }

    types = %{
      image: Exfile.Ecto.File,
      image_date_time_original: :string,
      image_exposure_time: :string
    }

    { data, types }
  end

  defp image_file() do
    %Plug.Upload{ path: "test/support/images/DSC08511s25.jpg", filename: "DSC08511s25.jpg" }
  end
end
