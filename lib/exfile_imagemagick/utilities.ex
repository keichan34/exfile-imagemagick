defmodule ExfileImagemagick.Utilities do
  @read_buffer 2048

  def file_to_tmpfile(file) do
    {:ok, io} = Exfile.File.download(file)
    random = :crypto.rand_uniform(100_000, 999_999)
    temp = Path.join(System.tmp_dir, "#{random}-#{file.id}")
    {:ok, true} = File.open temp, [:write, :binary], fn(f) ->
      Enum.into(
        IO.binstream(io, @read_buffer),
        IO.binstream(f, @read_buffer)
      )
      true
    end
    temp
  end
end
