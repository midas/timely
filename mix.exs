defmodule Timely.Mixfile do
  use Mix.Project

  def project do
    [app: :timely,
     version: "2.0.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  defp description do
    """
    Provides functions for converting, comparing and shifting Elixir dates/times.
    """
  end

  defp package do
    [
      name: :timely,
      files: [
        "lib",
        "mix.exs",
        "README*",
        "LICENSE*"
      ],
      maintainers: ["C. Jason Harrelson"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/midas/timely",
        "Docs"   => "https://hexdocs.pm/timely/2.0.0"
      }
    ]
  end

  def application do
    [
      extra_applications: [
        :logger
      ]
    ]
  end

  defp deps do
    [
      {:timex, ">= 3.0.0"},

      {:ex_doc, "~> 0.20", only: :dev}
    ]
  end

end
