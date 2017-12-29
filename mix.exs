defmodule Timely.Mixfile do
  use Mix.Project

  def project do
    [app: :timely,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
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
      {:ecto,  ">= 1.0.0"},
      {:timex, ">= 3.0.0"},

      {:ex_doc, "~> 0.18", only: :dev}
    ]
  end

end
