defmodule Kompl do
  def cut([_]) do 0 end
  def cut(list) do
    [s | seq] = msort(list)
    cut(seq, [s])
  end

  def cut([l], right) do
    cut(right) + l + sam(right, 0)
  end
  def cut(left, right) do
    alt1 = cut(left) + cut(right) + sam(left, 0) + sam(right, 0)
  end
  def sam([], s) do s end
  def sam([n | t], s) do
    sam(t, n+s)
  end

  def msort([]) do [] end
  def msort([elem]) do [elem] end
  def msort(l) do
    {list1, list2} = splat(l)
    merge(msort(list1), msort(list2))
  end

  def merge([], list2) do list2 end
  def merge(list1, []) do list1 end
  def merge([h1 | t1], [h2 | t2]) do
    cond do
      h1 > h2 -> [h1 | merge(t1, [h2 | t2])]
      true -> [h2 | merge([h1 | t1], t2)]
    end
  end
  def splat(lst) do splat(lst, [], []) end
  def splat(lst, sofar_one, sofar_two) do
    case lst do
      [] -> {sofar_one, sofar_two}
      [elem | tail] -> splat(tail, [elem | sofar_two], sofar_one)
    end
  end
end
