ExUnit.start()

defmodule EITH do
  def image_path(name),
    do: Path.join(~w(support images) ++ [name]) |> Path.expand(__DIR__)
end
