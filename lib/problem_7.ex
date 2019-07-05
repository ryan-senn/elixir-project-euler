# Problem description: https://projecteuler.net/problem=7

defmodule Problem7 do
  @index 10_001

  def solution_1 do
    solve_1(1, 2)
  end

  defp solve_1(i, n) do
    if is_prime?(n) do
      if i == @index do
        n
      else
        solve_1(i + 1, n + 1)
      end
    else
      solve_1(i, n + 1)
    end
  end

  defp is_prime?(n) do
    rec_is_prime?(n, 2)
  end

  defp rec_is_prime?(n, check) do
    if n == check do
      true
    else
      if rem(n, check) == 0 do
        false
      else
        rec_is_prime?(n, check + 1)
      end
    end
  end

  # def solution_2 do
  #   @todo, implement solution 2
  # end
end
