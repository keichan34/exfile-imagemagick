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

## Optional GraphicsMagick Configuration

Instead of ImageMagick you may optionally choose [GraphicsMagick](www.graphicsmagick.org) as image processor.

In `config.exs`:

```elixir
config :exfile_imagemagick, image_processor: :graphicsmagick
```

You also need to ensure that `GM` binary is in your environment's `PATH`.

See `ExfileImagemagick.Config` for defaults.
