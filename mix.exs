defmodule ElixirProjectEuler.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_project_euler,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:benchee, "~> 1.0", only: :dev}
    ]
  end

  defp aliases do
    [
      "problem.test": "elixir_project_euler.test_problem",
      "t": "elixir_project_euler.test_problem",
      "problem.benchmark": "elixir_project_euler.benchmark_problem",
      "bm": "elixir_project_euler.benchmark_problem",
      "problems.generate": "elixir_project_euler.generate_problems"
    ]
  end
end
