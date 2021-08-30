defmodule Derivativ do
  @type literal() :: {:num, number()}
                | {:var, atom()}

  @type expr() :: {:add, expr(), expr()}
            | {:mul, expr(), expr()}
            | literal()

  def deriv({:num, _}, _), do: 0

  def deriv({:var, v}, v), do: 1

  def deriv({:var, _}, _), do: 0

  def deriv({:mul, e1, e2}, v), do: {:add,{:mul,deriv(e1, v),e2},{:mul,e1,deriv(e2, v)}}

end
