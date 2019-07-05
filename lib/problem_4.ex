# Problem description: https://projecteuler.net/problem=4

defmodule Problem4 do
  @range 100..999
  def solution_1 do
    @range
    |> Enum.flat_map(fn i -> Enum.zip(Enum.map(@range, fn _ -> i end), @range) end)
    |> Enum.map(fn {l, r} -> l * r end)
    # add uniq before filtering, comparing ints is faster than running the palindrome check
    |> Enum.uniq()
    |> Enum.filter(fn n -> is_palindrome_string?(n) end)
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
    |> Enum.filter(fn n -> is_palindrome_string?(n) end)
    |> Enum.max()
  end

  # combine Enum.uniq, Enum.filter and Enum.max in another Enum.reduce
  def solution_3 do
    @range
    |> Enum.reduce([], fn i, acc ->
      Enum.map(@range, fn j -> i * j end) ++ acc
    end)
    |> Enum.reduce(0, fn n, acc ->
      # we have 2 checks to perform here, n > acc and is_palindrome_string?(n)
      # we want to use nested ifs here so that we can perform the cheap check first (n > acc)
      # and avoid calling is_palindrome_string?(n) in many instances
      if n > acc do
        if is_palindrome_string?(n) do
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

  # same as solution 3, but use digits instead of string to check for palindrome
  def solution_4 do
    @range
    |> Enum.reduce([], fn i, acc ->
      Enum.map(@range, fn j -> i * j end) ++ acc
    end)
    |> Enum.reduce(0, fn n, acc ->
      if n > acc do
        if is_palindrome_digits?(n) do
          n
        else
          acc
        end
      else
        acc
      end
    end)
    |> (fn n ->
          if n == 0 do
            nil
          else
            n
          end
        end).()
  end

  defp is_palindrome_string?(n) do
    string = Integer.to_string(n)

    string == String.reverse(string)
  end

  defp is_palindrome_digits?(n) do
    digits = Integer.digits(n)

    digits == Enum.reverse(digits)
  end
end

# Benchmarks

# Name                 ips        average  deviation         median         99th %
# solution_4         13.17       75.91 ms     ±9.84%       74.19 ms      105.86 ms
# solution_3         11.91       83.95 ms     ±9.53%       81.40 ms      116.90 ms
# solution_2          1.59      627.52 ms     ±5.06%      630.47 ms      676.80 ms
# solution_1          0.90     1110.61 ms     ±4.64%     1090.63 ms     1174.08 ms

# Comparison:
# solution_4         13.17
# solution_3         11.91 - 1.11x slower +8.04 ms
# solution_2          1.59 - 8.27x slower +551.61 ms
# solution_1          0.90 - 14.63x slower +1034.69 ms
