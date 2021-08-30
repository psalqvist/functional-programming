defmodule Tree do

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
    {k, v} = rightmost(left)
    {:node, k, v, delete(k, left), right}
  end
  def remove(key, {:node, k, v, left, right}) do
    if key < k do
      {:node, k, v, remove(key, left), right}
    else
      {:node, k, v, left, remove(key, right)}
    end
  end

  def rightmost2({:leaf, key, v, :nil, :nil}) do {key, v} end
  def rightmost2({:node, _, _, _, right}) do rightmost(right) end
end
