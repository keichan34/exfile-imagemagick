defmodule ExfileImagemagick.Convert do
  @moduledoc """
  Converts an image from one format to another.

  Arguments:

  * Destination format.

  "jpg" is aliased as "jpeg".
  """

  @behaviour Exfile.Processor

  import ExfileImagemagick.Utilities
  alias Exfile.LocalFile

  @format_synonyms %{
    "jpg" => "jpeg"
  }

  def call(file, [dest_format], _opts) do
    file = coerce_to_file(file)

    dest_format = String.downcase(dest_format)
    dest_format = Map.get(@format_synonyms, dest_format, dest_format)

    if should_format?(file, dest_format) do
      perform_format(file, dest_format)
    else
      {:ok, file}
    end
  end

  defp should_format?(%LocalFile{path: path}, dest_format) do
    case System.cmd("identify", ["-format", "%m", path]) do
      {current_format, 0} ->
        dest_format != String.downcase(current_format)
      _ ->
        false
    end
  end

  defp perform_format(%LocalFile{path: path, meta: meta}, dest_format) do
    new_path = Exfile.Tempfile.random_file!("imagemagick")
    convert_args = [
      path,
      "-auto-orient",
      dest_format <> ":" <> new_path
    ]
    case System.cmd("convert", convert_args) do
      {_, 0} ->
        meta = Map.put(meta, "format", String.upcase(dest_format))
        {:ok, %LocalFile{path: new_path, meta: meta}}
      {error, _} ->
        {:error, error}
    end
  end
end
