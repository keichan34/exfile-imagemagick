defmodule ExfileImagemagick.Converter do
  @behaviour Exfile.Processor

  import ExfileImagemagick.Utilities
  import Mogrify

  def call(file, [dest_format]) do
    image = file_to_tmpfile(file) |> open |> format(dest_format)
    {:ok, {:tempfile, image.path}}
  end
end
