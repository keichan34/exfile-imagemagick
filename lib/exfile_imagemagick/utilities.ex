defmodule ExfileImagemagick.Utilities do
  @moduledoc false

  alias Exfile.LocalFile

  def coerce_to_file(%LocalFile{path: nil} = file),
    do: LocalFile.copy_to_tempfile(file)
  def coerce_to_file(file),
    do: file

  def destination_with_format(path, opts) do
    case Keyword.fetch(opts, :format) do
      {:ok, dest_format} -> dest_format <> ":" <> path
      :error -> path
    end
  end
end
