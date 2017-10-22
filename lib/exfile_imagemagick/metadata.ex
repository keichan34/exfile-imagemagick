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
    case SysRunner.cmd("identify", ["-format", "format=%m\\nimage_size=%G\\n%[EXIF:*]", file.path]) do
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
          Map.put(map, key, value)
        _ ->
          map
      end
    end)
  end
end
