defmodule Mix.Tasks.ElixirProjectEuler.GenerateProblems do
  use Mix.Task
  alias Mix.Tasks.ElixirProjectEuler.Answers

  def run(args) do
    answers = Answers.list()

    Enum.each(answers, fn {problem_number, _} ->
      filename = "./lib/problem_#{problem_number}.ex"

      if File.exists?(filename) && Enum.at(args, 0) != "--force" do
        IO.puts(
          "Cowardly refusing to overwrite as file `#{filename}` already exists. It could result in lost solutions! Either delete the file or use `--force` to overwrite all problems."
        )
      else
        File.write(filename, boilerplate(problem_number))

        IO.puts("Generated #{filename}.")
      end
    end)
  end

  defp boilerplate(problem_number) do
    """
    # Problem description: https://projecteuler.net/problem=#{problem_number}

    defmodule Problem#{problem_number} do
      def solution_1 do
        # @todo, implement solution 1
      end

      # def solution_2 do
      #   @todo, implement solution 2
      # end
    end
    """
  end
end
