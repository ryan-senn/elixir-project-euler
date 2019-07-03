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
