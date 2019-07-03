defmodule Mix.Tasks.ElixirProjectEuler.TestProblem do
  use Mix.Task
  alias Mix.Tasks.ElixirProjectEuler.Util
  alias Mix.Tasks.ElixirProjectEuler.Answers

  def run(args) do
    problem_number = Enum.at(args, 0)

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
        if Enum.at(args, 1) == "--show" do
          IO.puts(
            "#{solution} failed. You've given me #{given_answer}, but I am expecting #{
              correct_answer
            }!"
          )
        else
          IO.puts("#{solution} failed. You've given me #{given_answer}, but it is incorrect! You can use the `--show` flag to display the correct answer.")
        end
      end
    end)
  end
end
