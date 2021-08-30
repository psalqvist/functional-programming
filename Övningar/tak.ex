defmodule Tak do
  def tak(list) do
    case list do
      [] -> :no
      _ -> [item | _] = list
      {:ok, item}
    end
  end

  def drp(list) do
    case list do
      [] -> :no
      _ -> [_ | new] = list
      {:ok, new}
    end
  end

  def len(list) do
    case list do
      [] -> 0
      [_] -> 1
      [_, _] -> 2
      _ -> len(list, 0)
    end
  end

  def len(list, acc) do
    case list do
      [] -> acc
      [head | tail] -> len(tail, acc + 1)
    end
  end

  def sum(list) do
    case list do
      [] -> 0
      [head | []] -> head
      _ -> sum(list, 0)
    end
  end

  def sum(list, sum) do
    case list do
      [] -> sum
      [head | tail] -> sum(tail, sum + head)
    end
  end

  def duplicate(list) do
    case list do
      [] -> []
      [a] -> [a*2]
      [a, b] -> [a*2, b*2]
      [head | tail] -> duplicate(list, [])
    end
  end

  def duplicate(list, new) do
    case list do
      [] -> new
      [head | tail] -> duplicate(tail, [head*2 | new])
    end
  end

  def add(x, list) do
    cond do
      list == [] -> list
      list != [] -> add(x, list, 0)
    end
  end

  def add(x, list, i) do
    cond do
      i > len(list) -> [x | list]
      Enum.at(list, i) == x -> list
      Enum.at(list, i) != x -> add(x, list, i+1)
    end
  end

#  def remove(x, list) do
#    case list do
#      [] -> list
#      _ -> remove(x, list, 0)
#    end
#  end

#  def remove(x, list, i) do
#    cond do
#      list == [] -> list
#      Enum.at(list, i) == x ->
#      _ -> remove(x, list, 0)
#    end
#  end

  def unique(list) do
    l = Enum.sort(list)
    case l do
      [] -> []
      [_] -> list
      _ -> unique(l, [], 0)
    end
  end

  def unique(list, new, i) do
    cond do
      i > len(list) -> new
      Enum.at(list, i) == Enum.at(list, i+1) -> unique(list, new, i+1)
      true -> unique(list, [Enum.at(list, i) | new], i+1)
    end
  end


  def append([], y) do y end

  def append([h|t], y) do
    z = append(t, y)
    [h | z]
  end


end
