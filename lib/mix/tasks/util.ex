defmodule Mix.Tasks.ElixirProjectEuler.Util do
  def get_problem_module(problem_number) do
    Module.concat(Elixir, "Problem#{problem_number}")
  end

  def get_solutions(module) do
    module.__info__(:functions)
    |> Enum.reduce([], fn {function_name, _}, acc ->
      if String.match?(Atom.to_string(function_name), ~r/^solution_[\d]+$/) do
        acc ++ [function_name]
      else
        acc
      end
    end)
  end
end
