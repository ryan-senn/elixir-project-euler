# Problem description: https://projecteuler.net/problem=4

defmodule Problem4 do
  @range 100..999
  def solution_1 do
    @range
    |> Enum.flat_map(fn i -> Enum.zip(Enum.map(@range, fn _ -> i end), @range) end)
    |> Enum.map(fn {l, r} -> l * r end)
    # add uniq before filtering, comparing ints is faster than running the palindrome check
    |> Enum.uniq()
    |> Enum.filter(fn n -> is_palindrome?(n) end)
    |> Enum.max()
  end

  # combine Enum.flat_map and Enum.zip in one Enum.reduce
  def solution_2 do
    @range
    |> Enum.reduce([], fn i, acc ->
      # This bit is actually super important!!!
      # Always concat enums with the small one on the left side of ++
      # Switch it around and it's about 8 times slower
      Enum.map(@range, fn j -> i * j end) ++ acc
    end)
    |> Enum.uniq()
    |> Enum.filter(fn n -> is_palindrome?(n) end)
    |> Enum.max()
  end

  # combine Enum.uniq, Enum.filter and Enum.max in another Enum.reduce
  def solution_3 do
    @range
    |> Enum.reduce([], fn i, acc ->
      Enum.map(@range, fn j -> i * j end) ++ acc
    end)
    |> Enum.reduce(0, fn n, acc ->
      # we have 2 checks to perform here, n > acc and is_palindrome?(n)
      # we want to use nested ifs here so that we can perform the cheap check first (n > acc)
      # and avoid calling is_palindrome?(n) in many instances
      if n > acc do
        if is_palindrome?(n) do
          n
        else
          acc
        end
      else
        acc
      end
    end)
    # to keep it consistent with the functions above, return nil if nothing is found
    # (not 0, which is the initial accumulator)
    |> (fn n ->
          if n == 0 do
            nil
          else
            n
          end
        end).()
  end

  defp is_palindrome?(n) do
    string = Integer.to_string(n)

    string == String.reverse(string)
  end
end

# Benchmarks

# Name                 ips        average  deviation         median         99th %
# solution_3         12.05       82.96 ms     ±9.38%       80.78 ms      104.94 ms
# solution_2          1.59      630.01 ms     ±5.80%      634.24 ms      680.38 ms
# solution_1          0.93     1077.65 ms     ±5.19%     1075.49 ms     1152.74 ms

# Comparison:
# solution_3         12.05
# solution_2          1.59 - 7.59x slower +547.05 ms
# solution_1          0.93 - 12.99x slower +994.70 ms
