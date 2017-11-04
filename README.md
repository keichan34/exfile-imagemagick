# ExfileImagemagick

[![Build Status](https://travis-ci.org/keichan34/exfile-imagemagick.svg?branch=master)](https://travis-ci.org/keichan34/exfile-imagemagick)

An [ImageMagick](http://www.imagemagick.org) file processor suite for [Exfile](https://github.com/keichan34/exfile).

## Requirements

* A working ImageMagick installation. `identify` and `convert` must be in the
  `PATH` of the running environment.
* Elixir `~> 1.2.0`

## Installation

  1. Add exfile_imagemagick to your list of dependencies in `mix.exs`:

        def deps do
          [{:exfile_imagemagick, "~> 0.1.4"}]
        end

  2. Ensure exfile_imagemagick is started before your application:

        def application do
          [applications: [:exfile_imagemagick]]
        end

## Usage

`exfile_imagemagick` automatically registers 4 processors:

* `convert`
* `fill`
* `limit`
* `metadata`

## Storing metadata to the database

You can `cast_metadata` for a file and store it to the database in separate fields:

``` elixir
defmodule MyApp.User do
  # definitions here

  import ExfileImagemagick.Ecto.CastMetadata

  def changeset(model, params) do
    model
    |> cast(params, [:avatar_image])
    |> cast_metadata(:avatar_image, "ExposureTime")
    |> cast_metadata(:avatar_image, "ExifOffset", :my_custom_ecto_field)
    |> cast_metadata(:avatar_image, "DateTimeOriginal", date_time_original: :naive_datetime)
    |> cast_metadata(:avatar_image, "MeteringMode", another_custom_field: :integer)
    |> ...
  end
end
```

In the example above the ecto field for `ExposureTime` is computed automatically as `image_exposure_time`.
`ExifOffset` value ist saved as string to `my_custom_ecto_field`.
`DateTimeOriginal` metadatavalue is converted to :naive_date_time and then saved  to `date_time_original` field. `MeteringMode` is converted to integer and saved to `another_custom_field`.

Generally, `cast_metadata` extracts values as strings. Type conversions to `:naive_datetime` and `:integer` are currently supported.

## Optional GraphicsMagick Configuration

Instead of ImageMagick you may optionally choose [GraphicsMagick](www.graphicsmagick.org) as image processor.

In `config.exs`:

```elixir
config :exfile_imagemagick, image_processor: :graphicsmagick
```

You also need to ensure that `gm` binary is in your environment's `PATH`.
Also note that you need to use GraphicsMagick v1.3.23 or higher as for older versions
EXIF data extraction would yield errors.

See `ExfileImagemagick.Config` for defaults.
