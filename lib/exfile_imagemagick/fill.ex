defmodule ExfileImagemagick.Fill do
  @behaviour Exfile.Processor

  import ExfileImagemagick.Utilities
  alias Exfile.LocalFile

  def call(file, [width, height], opts \\ []) do
    file = coerce_to_file(file)

    new_path = Exfile.Tempfile.random_file!("imagemagick")
    destination = destination_with_format(new_path, opts)

    dest_dimensions = to_string(width) <> "x" <> to_string(height)
    convert_args = [
      file.path,
      "-auto-orient",
      "-resize",
      dest_dimensions <> "^",
      "-gravity", "center",
      "-crop",
      dest_dimensions <> "+0+0",
      "+repage",
      destination
    ]

    case System.cmd("convert", convert_args) do
      {_, 0} ->
        {:ok, %LocalFile{path: new_path}}
      {error, _} ->
        {:error, error}
    end
  end
end
