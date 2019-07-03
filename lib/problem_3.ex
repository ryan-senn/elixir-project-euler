# Problem description: https://projecteuler.net/problem=3

defmodule Problem3 do
  require Integer

  def solution_1 do
    2..13195
    |> Enum.filter(fn i -> is_prime?(i, 2) end)
    |> IO.inspect()

    1
  end

  defp is_prime?(number, check) do
    # reached the end without finding a division, it's prime
    if(number == check) do
      true
    else
      # found a division, bail out
      if rem(number, check) == 0 do
        false
      else
        # keep searching
        is_prime?(number, check + 1)
      end
    end
  end
end
