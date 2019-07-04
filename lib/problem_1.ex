# Problem description: https://projecteuler.net/problem=1

defmodule Problem1 do
  # simple, naive approach: filter into sum
  def solution_1 do
    1..999
    |> Enum.filter(fn i -> rem(i, 3) == 0 || rem(i, 5) == 0 end)
    |> Enum.sum()
  end

  # reduce to loop only once instead
  def solution_2 do
    1..999
    |> Enum.reduce(0, fn i, acc ->
      if rem(i, 3) == 0 || rem(i, 5) == 0 do
        acc + i
      else
        acc
      end
    end)
  end

  # reduce with guarded pattern matching over a named function
  def solution_3 do
    1..999
    |> Enum.reduce(0, fn i, acc -> reduce_step(i, acc) end)
  end

  defp reduce_step(i, acc) when rem(i, 3) == 0 or rem(i, 5) == 0 do
    acc + i
  end

  defp reduce_step(_, acc) do
    acc
  end
end

# Benchmarks

# Name                 ips        average  deviation         median         99th %
# solution_3       19.95 K       50.14 μs    ±17.22%          48 μs          79 μs
# solution_2       15.80 K       63.29 μs    ±15.44%          61 μs         102 μs
# solution_1       11.25 K       88.92 μs   ±362.35%          82 μs         140 μs

# Comparison:
# solution_3       19.95 K
# solution_2       15.80 K - 1.26x slower +13.16 μs
# solution_1       11.25 K - 1.77x slower +38.79 μs
