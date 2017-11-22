defmodule ExfileImagemagick.Limit do
  @moduledoc """
  Resizes an image to fit the desired dimensions.

  The image will not be cropped, and the aspect ratio will be preserved.

  Arguments:

  * Width (in pixels)
  * Height (in pixels)

  Options:

  * `:format` - the desired format the output file should be in. Example: jpeg, png, gif, etc.
  """

  @behaviour Exfile.Processor

  import ExfileImagemagick.Utilities
  alias Exfile.LocalFile

  alias ExfileImagemagick.SysRunner

  def call(file, [width, height], opts) do
    file = coerce_to_file(file)

    new_path = Exfile.Tempfile.random_file!("imagemagick")
    destination = destination_with_format(new_path, opts)

    dest_dimensions = to_string(width) <> "x" <> to_string(height) <> ">"
    convert_args = [
      file.path,
      "-auto-orient",
      "-resize",
      dest_dimensions
    ] ++ extra_args(opts) ++ [destination]

    case SysRunner.cmd("convert", convert_args) do
      {_, 0} ->
        {:ok, %LocalFile{path: new_path}}
      {error, _} ->
        {:error, error}
    end
  end
end
