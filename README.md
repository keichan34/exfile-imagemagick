# ExfileImagemagick

[![Build Status](https://travis-ci.org/keichan34/exfile-imagemagick.svg?branch=master)](https://travis-ci.org/keichan34/exfile-imagemagick)

An ImageMagick file processor suite for [Exfile](https://github.com/keichan34/exfile).

## Installation

  1. Add exfile_imagemagick to your list of dependencies in `mix.exs`:

        def deps do
          [{:exfile_imagemagick, "~> 0.0.1"}]
        end

  2. Ensure exfile_imagemagick is started before your application:

        def application do
          [applications: [:exfile_imagemagick]]
        end
