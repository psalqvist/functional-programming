defmodule Tenta do
  def toggle([a]) do [a] end
  def toggle([a, b | tail]) do [b, a | toggle(tail)] end


  def toggle2([]) do [] end
  def toggle2([a]) do [a] end
  def toggle2([a, b]) do [b, a] end
  def toggle2([h1 | [h2 | tail]]) do
    return = toggle2([h1, h2]) ++ toggle2(tail)
  end

  def push(a, []) do [a] end
  def push(a, list) do [a|list] end

  def pop([]) do :no end
  def pop([h|tail]) do {:ok, h, tail} end

  def flatten([]) do [] end
  def flatten(list) do flatten(list, []) end
  def flatten([], acc) do acc end
  def flatten([head|tail], acc) do
    case head do
      [h | t] -> flatten(tail, [h | t] ++ acc)
      elem -> flatten(tail, [elem | acc])
    end
  end

  def flat([]) do [] end
  def flat([head|tail]) do flat(head) ++ flat(tail) end
  def flat(elem) do [elem] end

  def flut([]) do [] end
  def flut([[]|rest]) do flut(rest) end
  def flut([[head | tail] | rest]) do
    flut([head, tail | rest])
  end
  def flut([elem | rest]) do
    [elem | flut(rest)]
  end


  def index(list) do index(list, 0) end
  def index([], h) do h end
  def index([head | t], h) do
    cond do
      head > h -> index(t, h+1)
      true -> h
    end
  end

  @type tree() :: :nil | {:node, tree(), tree()} | {:leaf, any()}

   def compact(:nil) do :nil end
   def compact({:leaf, value}) do {:leaf, value} end
   def compact({:node, {:leaf, same}, {:leaf, same}}) do {:leaf, same} end
   def compact({:node, {:leaf, value1}, {:leaf, value2}}) do {:node, {:leaf, value1}, {:leaf, value2}} end
   def compact({:node, :nil, {:leaf, value}}) do {:leaf, value} end
   def compact({:node, {:leaf, value}, :nil}) do {:leaf, value} end
   def compact({:node, l, r}) do
     new = {:node, compact(l), compact(r)}
     compact(new)
   end


  def fib() do
    fn() -> fib(1,1) end
  end

  def fib(f1, f2) do
    [f1 | fn() -> fib(f2, f1+f2) end]
  end

  def primes() do
  fn() -> {:ok, 2, fn() -> sieve(2, fn() -> next(3) end) end} end
  end

  def next(n) do
  {:ok, n, fn() -> next(n+1) end}
  end


  def sieve(prime, fun) do
    {:ok, n, newfun} = fun.()
    cond do
      (rem(n, prime) == 0) -> sieve(prime, newfun)
      true -> {:ok, n, fn -> sieve(n, fn -> sieve(prime, newfun) end) end}
    end
  end



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











end
