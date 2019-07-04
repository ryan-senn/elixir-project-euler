# Problem description: https://projecteuler.net/problem=2

defmodule Problem2 do
  require Integer

  @max 4_000_000

  # Simple, naive approach. Generate all fib numbers, filter them on even, tally them up.
  def solution_1 do
    [1, 2]
    |> fib()
    |> Enum.filter(fn i -> Integer.is_even(i) end)
    |> Enum.sum()
  end

  defp fib(list) do
    next = Enum.at(list, -1) + Enum.at(list, -2)

    if next <= @max do
      fib(list ++ [next])
    else
      list
    end
  end

  # Recusrive function call that only carries the last 2 fib numbers and caches the sum as it goes
  # on named function pattern matching with guards
  def solution_2 do
    fib_2(1, 2, 2)
  end

  defp fib_2(n1, n2, sum) when n1 + n2 <= @max and Integer.is_even(n1 + n2) do
    fib_2(n2, n1 + n2, sum + n1 + n2)
  end

  defp fib_2(n1, n2, sum) when n1 + n2 <= @max do
    fib_2(n2, n1 + n2, sum)
  end

  defp fib_2(_, _, sum) do
    sum
  end

  # Recusrive function call that only carries the last 2 fib numbers and caches the sum as it goes
  # with a nested if condition. This allows to compute n1 + n2 only once and store it in a variable.
  def solution_3 do
    fib_3(1, 2, 2)
  end

  defp fib_3(n1, n2, sum) do
    next = n1 + n2

    if sum <= @max do
      if Integer.is_even(next) do
        fib_3(n2, next, sum + next)
      else
        fib_3(n2, next, sum)
      end
    else
      sum
    end
  end
end

# Benchmarks

# Name                 ips        average  deviation         median         99th %
# solution_3        1.68 M      596.63 ns   ±131.73%        1000 ns        1000 ns
# solution_2        1.34 M      745.77 ns   ±287.22%        1000 ns        1000 ns
# solution_1      0.0417 M    23964.56 ns    ±41.69%       23000 ns       45000 ns

# Comparison:
# solution_3        1.68 M
# solution_2        1.34 M - 1.25x slower +149.14 ns
# solution_1      0.0417 M - 40.17x slower +23367.93 ns
