defmodule ExfileImagemagick.Mixfile do
  use Mix.Project

  def project do
    [
      app: :exfile_imagemagick,
      version: "0.1.0",
      elixir: "~> 1.2.0",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,
      docs: [
        extras: ["README.md"]
      ],
      package: package,
      description: description
   ]
  end

  def application do
    [
      mod: {ExfileImagemagick, []},
      applications: [
        :logger,
        :exfile
      ]
    ]
  end

  defp deps do
    [
      {:exfile, "~> 0.1.1"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Keitaroh Kobayashi"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/keichan34/exfile-imagemagick",
        "Docs" => "http://hexdocs.pm/exfile_imagemagick/readme.html"
      }
    ]
  end

  defp description do
    """
    An ImageMagick file processor suite for Exfile.
    """
  end
end
