# Problem description: https://projecteuler.net/problem=5

defmodule Problem5 do
  @max 20

  def solution_1 do
    solve_1(@max, 1)
  end

  defp solve_1(n, check) do
    if is_divisible_1?(n, check) do
      n
    else
      solve_1(n + 1, 1)
    end
  end

  defp is_divisible_1?(n, check) do
    if check == @max do
      true
    else
      if rem(n, check) == 0 do
        is_divisible_1?(n, check + 1)
      else
        false
      end
    end
  end

  # optimise by checking the largest (unlikeliest) number first, this way we can trigger early returns
  def solution_2 do
    solve_2(@max, @max)
  end

  defp solve_2(n, check) do
    if is_divisible_2?(n, check) do
      n
    else
      solve_2(n + 1, @max)
    end
  end

  defp is_divisible_2?(n, check) do
    if check == 1 do
      true
    else
      if rem(n, check) == 0 do
        is_divisible_2?(n, check - 1)
      else
        false
      end
    end
  end
end

# Benchmarks

# Name                 ips        average  deviation         median         99th %
# solution_2         0.154         6.47 s     ±0.00%         6.47 s         6.47 s
# solution_1        0.0684        14.61 s     ±0.00%        14.61 s        14.61 s

# Comparison:
# solution_2         0.154
# solution_1        0.0684 - 2.26x slower +8.14 s
