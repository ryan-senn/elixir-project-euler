# Problem description: https://projecteuler.net/problem=6

defmodule Problem6 do
  @range 1..100

  def solution_1 do
    sum_square =
      @range
      |> Enum.map(fn i -> :math.pow(i, 2) end)
      |> Enum.sum()

    square_sum =
      @range
      |> Enum.sum()
      |> :math.pow(2)

      square_sum - sum_square
  end

  # Reduce over map + sum
  def solution_2 do
    sum_square =
      @range
      |> Enum.reduce(0, fn i, acc -> acc + :math.pow(i, 2) end)

    square_sum =
      @range
      |> Enum.sum()
      |> :math.pow(2)

      square_sum - sum_square
  end
end

# Benchmarks

# Name                 ips        average  deviation         median         99th %
# solution_2      130.60 K        7.66 μs   ±187.17%           7 μs          18 μs
# solution_1       97.61 K       10.24 μs   ±125.90%           9 μs          24 μs

# Comparison:
# solution_2      130.60 K
# solution_1       97.61 K - 1.34x slower +2.59 μs
