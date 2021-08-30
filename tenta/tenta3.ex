defmodule Tenta3 do
  def decode([]) do [] end
  def decode([head | tail]) do
    {value, number} = head
    decode(value, number, []) ++ decode(tail)
  end
  def decode(_, 0, return) do return end
  def decode(value, number, return) do
    decode(value, number - 1, [value | return])
  end

  def decode2([]) do [] end
  def decode2([{elem, 0} | rest]) do
    decode2(rest)
  end
  def decode2([{elem, n} | rest]) do
    [elem | decode2([{elem, n-1} | rest])]
  end

  def zip([], []) do [] end
  def zip([h1 | t1], [h2 | t2]) do
    [{h1, h2} | zip(t1, t2)]
  end


  #def max(a, b) do Kernel.max(a, b) end
  #def abs(x) do Kernel.abs(x) end
  def balance(:nil) do {0, 0} end
  def balance({:node, _, l, r}) do
    depthl = depth(l, 0)
    depthr = depth(r, 0)
    depth = max(depthl, depthr)

  end

  def depth(:nil, depth) do depth end
  def depth({:node, _, l, r}, depth) do
    max(depth(l, depth + 1), depth(r, depth + 1))
  end



  def balance2(:nil) do {0,0} end
  def balance2({:node, _, left, right}) do
    {dl, il} = balance2(left)
    {dr, ir} = balance2(right)
    depth = max(dl, dr) + 1
    imbalance = max(max(il, ir), abs(dl-dr))
    {depth, imbalance}
  end


  def eval({op, expr1, expr2}) do
    case op do
      :add -> eval(expr1) + eval(expr2)
      :mul -> eval(expr1) * eval(expr2)
    end
  end
  def eval({:neg, expr}) do -eval(expr) end
  def eval(int) do int end

  def gray(0) do [] end
  def gray(1) do [[0], [1]] end
  def gray(n) do
    list1 = gray(n-1)
    list2 = Enum.reverse(list1)
    update1 = update(list1, 0)
    update2 = update(list2, 1)
    append(update1, update2)
  end

  def update([], _) do [] end
  def update([ list | rest], n) do
    [[n | list] | update(rest, n)]
  end

  def append(list1, list2) do
  case list1 do
    [] -> list2
    [h | t] -> [h | append(t, list2)]
  end
end




end
