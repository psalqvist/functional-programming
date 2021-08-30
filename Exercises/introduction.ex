defmodule Recursion do
  def fib(0) do 0 end
  def fib(1) do 1 end
  def fib(n) do
    fib(n-1) + fib(n-2)
  end

  # svansrekorsion/stackoptimering
  # när sista anropet är det rekursiva, kan vi återanvända samma stackram


  def union([], y) do y end
  def union([h|t], y) do
    z = union(t, y)
    [h | z]
  end

  def tail_union([], y) do y end
  def tailr([h | t], y) do
    z = [h | y]
    tailr(t, z)
  end

  # ej svansrekursiv sum
  def sum([]) do 0 end
  def sum([n|t]) do
    n + sum(t)
  end
  # svansrekursiv
  def sam([], s) do s end
  def sam([n | t], s) do
    sam(t, n+s)
  end

  # odd n even ej svansrekursiv
  def odd_n_even(lst) do
    o = odd(lst)
    e = even(lst)
    {o, e}
  end

  def odd([]) do [] end
  def odd([h | t]) do
    if rem(h, 2) == 1 do
      [h|odd(t)]
    else
      odd(t)
    end
  end

  # even
  def even([]) do [] end
  def even([h|t]) do
    if rem(h, 2) == 0 do
      [h|even(t)]
    else
      even(t)
    end
  end

  # ej svansrekursiv, men bygger bara på stacken en gång
  def udd_n_even([]) do {[], []} end
  def udd_n_even([h|t]) do
    {o, e} = odd_n_even(t)
    if rem(h, 2) == 1 do
      {[h|o], e}
    else
      {o, [h|e]}
    end
  end

  # svansrekursiv
  def add_n_even(lst) do add_n_even(lst, [], []) end

  def add_n_even([], odd, even) do {odd, even} end
  def add_n_even([h|t], odd, even) do
    if rem(h, 2) == 1 do
      add_n_even(t, [h | odd], even)
    else
      add_n_even(t, odd, [h | even])
    end
  end

  # flatten, ej svansrekursiv
  def flat([]) do [] end
  def flat([l | t]) do
    l ++ flat(t)
  end

  # svansrekursiv
  # Vi betalar för längden på den vänstra listan i appenden
  # Den ej svansrekursiva är snabbare, då vänstra listan inte
  # växer lika snabbt
  def flut(lst) do flut(lst, []) end

  def flut([], res) do res end
  def flut([h | t], res) do
    flut(t, res ++ h)
  end

  # best flatten
  def flet([]) do [] end
  def flet([[] | rest]) do
    flet(rest)
  end
  def flet([[head | tail] | rest]) do
    flet([head, tail | rest])
  end
  def flet([ elem | rest]) do
    [elem | flet(rest)]
  end

  def append([], list) do list end
  def append([h | t], list) do [h | append(t, list)] end


end

defmodule Lists do
  def tak([]) do :noelement end
  def tak([h | t]) do h end

  def duplicate([]) do [] end
  def duplicate([h | t]) do [h, h | duplicate(t)] end

  def add(x, []) do [x] end
  def add(x, [x | t]) do [x | t] end
  def add(x, [h | t]) do [h | add(x, t)] end

  def remove(x, []) do [] end
  def remove(x, [x | t]) do t end
  def remove(x, [h | t]) do [h | remove(x, t)] end

  def unique([]) do [] end
  def unique([h | t]) do
    [h | unique(remove(h, t))]
  end

  # write a function that returns a list containing lists of same element
  def pack([]) do [] end
  def pack([h | t]) do
    {all, rest} = match(h, t, [h], [])
    [all | pack(rest)]
  end

  def match(_, [], all, rest) do {all, rest} end
  def match(h, [h | tail], all, rest) do
    match(h, tail, [h | all], rest)
  end
  def match(h, [h2 | tail], all, rest) do
    match(h, tail, all, [h2 | rest])
  end

  def append([], list) do list end
  def append([h | t], list) do [h | append(t, list)] end

  def nreverse([]) do [] end

  def nreverse([h | t]) do
    # skulle kunna skriva nreverse(t) ++ [h]
    r = nreverse(t)
    append(r, [h])
  end

  #svansrekursiv
  def reverse(list) do reverse(list, []) end
  def reverse([], acc) do acc end
  def reverse([h | t], acc) do
    reverse(t, [h | acc])
  end



end

defmodule Queue do

  def test() do
    ls = Enum.to_list(1..20)
    empty = {:queue, [], []}
    updated = List.foldl(ls, empty, fn(i,a) ->  add(a, i) end)
    List.foldl( ls, {:ok, nil, updated}, fn(_,{:ok, _, a}) ->  remove(a) end)
  end

  def add({:queue, front, back}, elem) do
    {:queue, front, [elem|back]}
  end

  def remove({:queue, [], []}) do :fail end

  def remove({:queue, [elem|rest], back}) do
    {:ok, elem, {:queue, rest, back}}
  end

  def remove({:queue, [], back}) do
    [elem|rest] = reverse(back)
    {:ok, elem, {:queue, rest, []}}
  end

  defp reverse(l) do reverse(l, []) end

  defp reverse([], r) do r end
  defp reverse([h|t], r) do
    reverse(t, [h|r])
  end

end
