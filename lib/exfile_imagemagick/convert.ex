defmodule ExfileImagemagick.Convert do
  use Exfile.Processor

  import Mogrify

  def call(file, [dest_format]) do
    image = coerce_file_to_tempfile(file, true) |> open |> format(dest_format)
    {:ok, {:tempfile, image.path}}
  end
end
