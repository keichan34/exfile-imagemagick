defmodule ExfileImagemagick.Mixfile do
  use Mix.Project

  def project do
    [
      app: :exfile_imagemagick,
      version: "0.1.4",
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      docs: [
        extras: ["README.md"]
      ],
      package: package(),
      description: description(),
      aliases: [
        "publish": [&git_tag/1, "hex.publish", "hex.docs"]
      ]
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
      {:exfile, "~> 0.3.1"},
      {:poolboy, "~> 1.5.1"},
      {:ecto, "~> 1.0 or ~> 2.0", optional: true},
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

  defp git_tag(_args) do
    version_tag = case Version.parse(project()[:version]) do
      {:ok, %Version{pre: []}} ->
        "v" <> project()[:version]
      _ ->
        raise "Version should be a release version."
    end
    System.cmd "git", ["tag", "-a", version_tag, "-m", "Release #{version_tag}"]
    System.cmd "git", ["push", "--tags"]
  end
end
