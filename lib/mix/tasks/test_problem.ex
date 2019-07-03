defmodule Mix.Tasks.ElixirProjectEuler.TestProblem do
  use Mix.Task
  alias Mix.Tasks.ElixirProjectEuler.Util
  alias Mix.Tasks.ElixirProjectEuler.Answers

  def run([problem_number]) do
    IO.puts("Testing problem #{problem_number}")

    correct_answer =
      problem_number
      |> String.to_integer()
      |> Answers.get_answer()

    module = Util.get_problem_module(problem_number)
    solutions = Util.get_solutions(module)

    solutions
    |> Enum.each(fn solution ->
      given_answer = apply(module, solution, [])

      if given_answer == correct_answer do
        IO.puts("#{solution} is correct. Well done!")
      else
        IO.puts(
          "#{solution} failed. You've given me #{given_answer}, but I am expecting #{
            correct_answer
          }!"
        )
      end
    end)
  end
end
