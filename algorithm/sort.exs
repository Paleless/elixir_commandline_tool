defmodule Sort do
  def quick_sort([x]), do: [x]
  def quick_sort([]), do: []

  def quick_sort([x | xs]) do
    left = Enum.filter(xs, fn n -> n < x end)
    right = xs -- left
    quick_sort(left) ++ [x] ++ quick_sort(right)
  end

  def merge_sort([]), do: []
  def merge_sort([x]), do: [x]

  def merge_sort(xs) do
    middle_index =
      xs
      |> length()
      |> div(2)

    left = Enum.take(xs, middle_index)
    right = xs -- left
    merge(merge_sort(left), merge_sort(right), [])
  end

  defp merge(left, [], accu), do: accu ++ left
  defp merge([], right, accu), do: accu ++ right

  defp merge([x1 | xs1], [x2 | xs2], accu) do
    case x1 < x2 do
      true ->
        merge(xs1, [x2 | xs2], accu ++ [x1])

      _ ->
        merge([x1 | xs1], xs2, accu ++ [x2])
    end
  end

  def insert_sort(xs) do
  end
end

Sort.quick_sort([1, -1, -20, -3]) |> IO.inspect()
Sort.merge_sort([1, -1, -20, -3]) |> IO.inspect()
