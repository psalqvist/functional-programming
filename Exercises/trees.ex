defmodule Tree do
  # @type tree() :: :nil | {:leaf, value} | {:node, value left, right}

  def member(_ , :nil) do :no end
  def member(elem, {:leaf, elem}) do :yes end
  def member(_, {:leaf, elem}) do :no end

  def member(elem, {:node, elem, _, _}) do :yes end
  def member(elem, {:node, value, left, right}) do
    cond do
      elem > value -> member(elem, right)
      elem < value -> member(elem, left)
    end
  end

  def insert(elem, :nil) do {:leaf, elem} end
  def insert(elem, {:leaf, value}) when elem > value do
    {:node, elem, {:leaf, value}, :nil}
  end
  def insert(elem, {:leaf, value}) do
    {:node, elem, :nil, {:leaf, value}}
  end
  def insert(elem, {:node, value, left, right}) when elem > value do
    {:node, value, left, insert(elem, right)}
  end
  def insert(elem, {:node, value, left, right}) do
    {:node, value, insert(elem, left), right}
  end

  def delete(e, {:leaf, e}) do  :nil  end
  def delete(e, {:node, e, :nil, right}) do right end
  def delete(e, {:node, e, left, :nil}) do left end
  def delete(e, {node, e, left, right}) do
    elem = rightmost(left)
    {:node, elem, delete(elem, left), right}
  end
  def delete(e, {node, v, left, right}) when e < v do
    {:node, v,  delete(e, left),  right}
  end
  def delete(e, {node, v, left, right})  do
    {:node, v,  left, delete(e, right)}
  end

  def rightmost({:leaf, elem}) do elem end
  def rightmost({:node, _, _, right}) do rightmost(right) end

  # depth and imbalance

  def balance(:nil) do {0,0} end
  def balance({:node, _, left, right}) do
    {dl, il} = balance(left)
    {dr, ir} = balance(right)
    depth = max(dl, dr) + 1
    imbalance = max(max(il, ir), abs(dl-dr))
    {depth, imbalance}
  end

  # key value pair trees

  def remove(key, {:node, key, _, :nil, :nil}) do
    :nil
  end
  def remove(key, {:node, key, _, left, :nil}) do
    left
  end
  def remove(key, {:node, key, _, :nil, right}) do
    right
  end
  def remove(key, {:node, key, _, left, right}) do
    {k, v} = rightmost2(left)
    {:node, k, v, remove(k, left), right}
  end
  def remove(key, {:node, k, v, left, right}) do
    if key < k do
      {:node, k, v, remove(key, left), right}
    else
      {:node, k, v, left, remove(key, right)}
    end
  end

  def rightmost2({:node, key, v, :nil, :nil}) do {key, v} end
  def rightmost2({:node, _, _, _, right}) do rightmost(right) end


  def insert(key, value, :nil)  do  {:node, key, value, :nil, :nil}  end
  def insert(key, value, {:node, key, v, left, right}) do
    {:node, key, value, left, right}
  end
  def insert(key, value, {:node, k, v, left, right}) do
    if key < k do
      {:node, k, v, insert(key, value, left), right}
    else
      {:node, k, v, left, insert(key, value, right)}
    end
  end

  def lookup(key, :nil) do :no end
  def lookup(key, {:node, key, value, _, _}) do {:ok, value} end
  def lookup(key, {:node, k, _, left, right}) do
    if key < k do
      lookup(key, left)
    else
      lookup(key, right)
    end
  end


end
