defmodule ExfileImagemagick.SysRunner do
  alias ExfileImagemagick.Server

  @image_processor Application.get_env(:exfile_imagemagick, :image_processor, :imagemagick)

  def generic_cmd(command, args) do
    :poolboy.transaction(:exfile_imagemagick_processors, fn(w) ->
      Server.cmd(w, command, args)
    end)
  end

  def image_cmd(command, args) do
    :poolboy.transaction(:exfile_imagemagick_processors, fn(w) ->
      case @image_processor do
        :graphicsmagick -> Server.cmd(w, "GM", ([command] ++ args))
        _ -> Server.cmd(w, command, args)
      end
    end)
  end
end
