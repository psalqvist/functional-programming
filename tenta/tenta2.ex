defmodule Tenta2 do
  def drop(list, n) do drop(list, n, 1) end
  def drop([], _, _) do [] end
  def drop([h|t], n, count) do
    cond do
      rem(count, n) == 0 -> drop(t, n, count + 1)
      true -> [h|drop(t, n, count + 1)]
    end
  end

  def append([], y) do y end

  def append([h|t], y) do
    z = append(t, y)
    [h | z]
  end

  def reverse([]) do [] end

  def reverse([h | t]) do
    r = reverse(t)
    append(r, [h])
  end

  def rotate(list, n) do
    {first, second} = split(list, n)
    rev_this = append(first, second)
    reverse(rev_this)
  end

  def split(list, n) do split(list, n, 1, [], []) end
  def split([], _, _, first, second) do {first, second} end
  def split([h | t], n, i, first, second) do
    cond do
      i <= n -> split(t, n, i + 1, [h | first], [])
      true -> split(t, n, i + 1, first, [h | second])
    end
  end

  def nrotate(list, n) do nrotate(list, n, []) end
  def nrotate(tail, 0, first) do
    append(tail, reverse(first))
  end
  def nrotate([h | tail], n, first) do
    nrotate(tail, n - 1, [h | first])
  end

  def nth(1, {:leaf, value}) do {:found, value} end
  def nth(n, {:leaf, value}) do {:cont, n-1} end
  def nth(n, {:node, l, r}) do
    case nth(n, l) do
      {:found, val} -> {:found, val}
      {:cont, k} -> nth(k, r)
    end
  end

  def hp35(list) do hp35(list, []) end

  def hp35([], [result | _]) do result end

  def hp35([:add | tail], [a, b | rest]) do hp35(tail, [a + b | rest]) end
  def hp35([:sub | tail], [a, b | rest]) do hp35(tail, [b - a | rest]) end

  def hp35([head | tail], stack) do hp35(tail, [head | stack]) end



  def pascal(1) do [1] end
  def pascal(n) do
    [1 | next(pascal(n - 1))]
  end

  def next([1]) do [1] end
  def next([a | [b | t]]) do
    [a + b | next([b | t])]
  end



end
