defmodule ExfileImagemagick.Fill do
  use Exfile.Processor

  import Mogrify

  def call(file, [width, height]) do
    image = coerce_file_to_tempfile(file, true)
      |> open
      |> resize_to_fill(width <> "x" <> height)

    {:ok, {:tempfile, image.path}}
  end
end
