# Problem description: https://projecteuler.net/problem=3

defmodule Problem3 do
  @number 600_851_475_143

  # General idea is to start with the number and factor of 2 (all numbers are divisible by 1, so we skip 1)
  # We check if the number is divisible by the factor (with a remainder of 0).
  # If yes, call the function again with the division as the new number to find,
  # but keep the same factor as the new number might be divisible by the same factor again!
  # If no, call the function again with the unchanged number and a factor increased by 1
  # Once number == factor, we found our solution

  # using ifs
  def solution_1 do
    solve(@number, 2)
  end

  defp solve(number, factor) do
    if number == factor do
      number
    else
      if rem(number, factor) == 0 do
        solve(div(number, factor), factor)
      else
        solve(number, factor + 1)
      end
    end
  end

  # using pattern matching and guards on named functions
  def solution_2, do: solve_2(@number, 2)

  defp solve_2(number, factor) when number == factor, do: number

  defp solve_2(number, factor) when rem(number, factor) == 0,
    do: solve_2(div(number, factor), factor)

  defp solve_2(number, factor), do: solve_2(number, factor + 1)

  # same, except for the first guard, see comment below
  def solution_3, do: solve_3(@number, 2)

  # interesting trick here: by naming both variables the same,
  # we can omit the `when number == factor` guard, as they have to be the same!
  defp solve_3(n, n), do: n

  defp solve_3(number, factor) when rem(number, factor) == 0,
    do: solve_3(div(number, factor), factor)

  defp solve_3(number, factor), do: solve_3(number, factor + 1)
end
