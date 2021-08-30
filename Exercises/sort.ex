defmodule Sort do

  # insert sort
  def isort(list) do isort(list, []) end
  def isort([], acc) do acc end
  def isort([h | t], acc) do isort(t, insert(h, acc)) end



  def insert(element, []) do [element] end
  def insert(element, [h | t]) do
    cond do
      element < h -> [element | [h | t]]
      true -> [h | insert(element, t)]
    end
  end

  def append([], list) do list end
  def append([h | t], list) do [h | append(t, list)] end


  # merge sort

  def msort([]) do [] end
  def msort([elem]) do [elem] end
  def msort(l) do
    {list1, list2} = split(l)
    merge(msort(list1), msort(list2))
  end

  def merge([], list2) do list2 end
  def merge(list1, []) do list1 end
  def merge([h1 | t1], [h2 | t2]) do
    cond do
      h1 < h2 -> [h1 | merge(t1, [h2 | t2])]
      true -> [h2 | merge([h1 | t1], t2)]
    end
  end


  def split(list) do split(list, [], []) end

  def split([], list1, list2) do {list1, list2} end
  def split([h | t], list1, list2) do
    split(t, list2, [h | list1])
  end

  def splet(lst) do
    case lst do
      [] -> {[], []}
      [a, b | tail] ->
        {one, two} = split(lst)
        {[a | one], [b | two]}
    end
  end

  def splat(lst) do splat(lst, [], []) end

  def splat(lst, sofar_one, sofar_two) do
    case lst do
      [] -> {sofar_one, sofar_two}
      [elem | tail] -> splat(tail, [elem | sofar_two], sofar_one)
    end
  end

  # quick sort

  def qsort([]) do [] end
  def qsort([p | tail]) do
    {small, large} = qsplit(p, tail, [], [])
    small = qsort(small)
    large = qsort(large)
    append(small, [p | large])
  end

  def qsplit(_, [], small, large) do {small, large} end
  def qsplit(p, [head | tail], small, large) do
    cond do
      head > p -> qsplit(p, tail, small, [head | large])
      true -> qsplit(p, tail, [head | small], large)
    end
  end

  # int to binary

  def to_binary(0) do [] end

  def to_binary(n) do
    append(to_binary(div(n,2)), [rem(n, 2)])
  end

  def to_better(n) do to_better(n, []) end
  def to_better(0, list) do list end
  def to_better(n, list) do
    to_better(div(n, 2), [rem(n, 2) | list])
  end

  # Convert a binary to an integer.
  def to_integer(x) do to_integer(x, 0) end
  def to_integer([], n) do n end
  def to_integer([x | r], n) do
    to_integer(r, 2 * n + x)
  end


end
