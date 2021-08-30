defmodule Sort do
  # Se skärmsdumpar
  def insert(el, [], acc) do [el] end
  def insert(el, [h|t], acc) do
    cond do
      el < h -> append(acc, [el | [h|t]])
      true -> insert(el, t, [h|acc])
    end
  end

  def append([], y) do y end

  def append([h|t], y) do
    z = append(t, y)
    [h | z]
  end

  def isort(l) do
    case l do
      [] -> []
      [h|t] ->
    end
  end


end
