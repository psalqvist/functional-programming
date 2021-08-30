defmodule Blandat do
  def fizzbuzz(n) do fizzbuzz(1, n+1, 1, 1) end

  def fizzbuzz(n, n, _, _) do [] end
  def fizzbuzz(next, n, 3, 5) do [:fizzbuzz | fizzbuzz(next+1, n, 1, 1)] end
  def fizzbuzz(next, n, 3, k) do [:fizz | fizzbuzz(next+1, n, 1, k+1)] end
  def fizzbuzz(next, n, j, 5) do [:buzz | fizzbuzz(next+1, n, j+1, 1)] end
  def fizzbuzz(next, n, j, k) do [next | fizzbuzz(next+1, n, j+1, k+1)] end

  def fairly(:nil) do {:ok, 0} end
  def fairly({:node, l, r}) do
    case fairly(l) do
      {:ok, dl} ->
        case fairly(r) do
          {:ok, dr} ->
            depth = max(dl, dr) + 1
            imd = abs(dl-dr)
            cond do
              imd <= 1 -> {:ok, depth}
              true -> :no
            end
          :no -> :no
        end
      :no -> :no
    end
  end



  def sum(:nil) do 0 end
  def sum({:node, int, l, r}) do
  int + sum(l) + sum(r)
  end


  def append2(lst1, lst2) do append2(lst1, lst2, []) end
  def append2([], [], acc) do reverse(acc) end
  def append2([h | t], lst2, acc) do
    append2(t, lst2, [h | acc])
  end
  def append2([], [h | t], acc) do
    append2([], t, [h | acc])
  end

  def append(a, b) do reverse(reverse(a), b) end


  def reverse(lst) do reverse(lst, []) end
  def reverse([], acc) do acc end
  def reverse([h | t], acc) do
    reverse(t, [h | acc])
  end

  def transf(_, _, []) do [] end
  def transf(x, y, [x | t]) do
    transf(x, y, t)
  end
  def transf(x, y, [h | t]) do
    [h*y | transf(x, y, t)]
  end

  def sam([]) do 0 end
  def sam([h | t]) do
    rest = sam(t)
    h + rest
  end

  def som(lst) do som(lst, 0) end
  def som([], sum) do sum end
  def som([h | t], sum) do
    som(t, sum + h)
  end

  @type tree() :: :nil, {:node, any(), tree(), tree()}

  def mini(tree) do mini(tree, :inf) end
  def mini(:nil, acc) do acc end
  def mini({:node, v, l, r}, acc) do
    cond do
      v < acc -> mini(l, mini(r, v))
      true -> mini(l, min(r, acc))
    end
  end

  def freq(key, []) do [{key, 1}] end
  def freq(key, [{key, freq} | tail]) do [{key, freq+1} | tail] end
  def freq(key, [h | t]) do
    [h | freq(key, t)]
  end

  def fraq(lst) do fraq(lst, []) end
  def fraq([], acc) do acc end
  def fraq([key | t], acc) do
    fraq(t, freq(key, acc))
  end
  # fungerar också som fraq
  def froq([]) do [] end
  def froq([h | t]) do
    freq(h, froq(t))
  end

  def new() do {:queue, [], []} end

  def enqueue(elem, {:queue, first, last}) do
    {:queue, first, [elem | last]}
  end

  def dequeue({:queue, [], []}) do
    :fail
  end
  def dequeue({:queue, [], last}) do
    new = {:queue, Enum.reverse(last), []}
    dequeue(new)
  end
  def dequeue({:queue, [h | t], last}) do
    {:ok, h, {:queue, t, last}}
  end

  def app_queue({:queue, f1, l1}, {:queue, f2, l2}) do
    {:queue, append(f1, reverse(l1)), append(l2, reverse(f2))}
  end

  def str_append(a, b) do
    {:str, a, b}
  end
  # You have to use 'hello' to get a list of chars
  def str_to_list({:str, lst}) do lst end
  def str_to_list({:str, s1, s2}) do
    append3(str_to_list(s1), str_to_list(s2))
  end

  def append3([], lst2) do lst2 end
  def append3([h | t], lst2) do
    [h | append3(t, lst2)]
  end


end
