defmodule ExfileImagemagick.SysRunner do
  alias ExfileImagemagick.Server


  def cmd(command, args) do
    :poolboy.transaction(:exfile_imagemagick_processors, fn(w) ->
      Server.cmd(w, command, args)
    end)
  end
end
