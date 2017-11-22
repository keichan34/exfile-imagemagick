defmodule ExfileImagemagick.Metadata do
  @moduledoc """
  An Exfile Processor to extract image metadata from an image.

  Uses ImageMagick's `identify` command. EXIF data is extracted as well, put in
  to the `meta` map with keys prefixed with `"exif:"`.

  Arguments: none.

  Options: none.
  """

  @behaviour Exfile.Processor

  import ExfileImagemagick.Utilities

  alias ExfileImagemagick.SysRunner

  def call(file, _, _) do
    file = coerce_to_file(file)
    format = "format=%m\\nimage_size=%G\\nquality=%Q\\n%[EXIF:*]%[JPEG-*]"
    case SysRunner.cmd("identify", ["-format", format, file.path]) do
      {out, 0} ->
        meta = Map.merge file.meta, extract_meta(out)
        {:ok, %{file | meta: meta}}
      {_, 1} ->
        {:error, :ident_error}
    end
  end

  defp extract_meta(identify) do
    identify
    |> String.split("\n")
    |> Enum.reduce(%{}, fn(x, map) ->
      case String.split(x, "=") do
        [key, value] ->
          # Imagemagick produces EXIF file information as "exif:DateTimeOriginal"
          # while GraphicsMagick produces the same information as "DateTimeOriginal"
          # Thus we normalize EXIF keys to the GraphicsMagick format convention
          cleaned_key = String.replace(key, "exif:","")
          Map.put(map, cleaned_key, value)
        _ ->
          map
      end
    end)
  end
end
