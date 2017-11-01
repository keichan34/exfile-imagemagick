use Mix.Config


# You can configure the image_processor to be one of :imagemagick or :graphicsmagick
# The default image processor is :imagemagick
#
# In case of imagemagick make sure that `convert` executable is in your environment's path
# In case of graphicsmagick make sure that `GM` executable is in your environment's path
#
#config :exfile_imagemagick, image_processor: :imagemagick

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
import_config "#{Mix.env}.exs"
