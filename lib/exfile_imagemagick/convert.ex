defmodule ExfileImagemagick.Convert do
  use Exfile.Processor

  import Mogrify

  def call(file, [dest_format]) do
    image = coerce_file_to_tempfile(file, true) |> open |> format(dest_format)
    Exfile.Tempfile.register_file(image.path)
    {:ok, {:tempfile, image.path}}
  end
end
