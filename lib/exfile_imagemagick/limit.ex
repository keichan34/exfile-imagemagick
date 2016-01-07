defmodule ExfileImagemagick.Limit do
  use Exfile.Processor

  import Mogrify

  def call(file, [width, height]) do
    image = coerce_file_to_tempfile(file, true)
      |> open
      |> resize_to_limit(width <> "x" <> height)

    {:ok, {:tempfile, image.path}}
  end
end
