defmodule Recursion do

  @doc """
  Compute the product between of n and m.

  product of n and m :
    if n is 0
      then ...
    otherwise
      the result ...
  """
  def prod(m, n) do
    cond do
      m == 0 -> 0
      m>0 and n>0 or m>0 and n<0 -> prod(m-1,n) + n
      m<0 and n<0 or m<0 and n>0 -> prod(m+1,n) - n
    end
  end

  def pow(m, n) do
    cond do
      m == 0 -> 0
      n == 0 -> 1
      true -> pow(m, n-1)*m

    end
  end

  def qpow(m,n) do
    cond do
      m == 0 -> 0
      n == 0 -> 1
      rem(n,2) == 0 -> pow(m*m, div(n,2))
      rem(n,2) != 0 -> m*pow(m*m, div(n-1,2))
    end
  end

end
