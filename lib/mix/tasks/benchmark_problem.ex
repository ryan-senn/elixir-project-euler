defmodule Mix.Tasks.ElixirProjectEuler.BenchmarkProblem do
  use Mix.Task
  alias Mix.Tasks.ElixirProjectEuler.Util

  def run([problem_number]) do
    module = Util.get_problem_module(problem_number)
    solutions = Util.get_solutions(module)

    solutions
    |> Enum.reduce(%{}, fn solution, acc ->
      Map.merge(acc, %{"#{solution}" => fn -> apply(module, solution, []) end})
    end)
    |> Benchee.run()
  end
end
