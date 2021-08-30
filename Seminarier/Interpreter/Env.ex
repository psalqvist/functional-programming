defmodule Env do
  def new() do [] end

  def add(id, str, []) do [{id, str}] end
  def add(id, str, list) do
    [{id, str}|list]
  end

  def lookup(_, []) do :nil end
  def lookup(id, [{id, str}|tail]) do {id, str} end
  def lookup(id, [head|tail]) do
    lookup(id, tail)
  end

  def remove(ids, []) do [] end
  def remove([], env) do env end
  def remove([id|rest], env) do
    remove(rest, remove_el(id, env, []))
  end


  def remove_el(id, [{id, _} | tail], acc) do acc++tail end
  def remove_el(id, [head | tail], acc) do
    remove_el(id, tail, [head | acc])
  end
  def remove_el(id, [], acc) do acc end
end

defmodule Eager do

  def eval_expr({:atm, id}, _) do {:ok, id} end

  def eval_expr({:var, id}, env) do
    case Env.lookup(id, env) do
      nil ->
        :error
      {_, str} ->
        {:ok, str}
    end
  end

  def eval_expr({:cons, e1, e2}, env) do
    case eval_expr(e1, env) do
      :error ->
        :error
      {:ok, str1} ->
        case eval_expr(e2, env) do
          :error ->
            :error
          {:ok, str2} ->
            {:ok, {str1, str2}}
        end
    end
  end

  def eval_match(:ignore, str, env) do
    {:ok, env}
  end

  def eval_match({:atm, id}, str, env) do
    {:ok, env}
  end

  def eval_match({:var, id}, str, env) do
    case Env.lookup(id, env) do
      nil ->
        {:ok, [{id, str} | env]}
      {_, ^str} ->
        {:ok, env}
      {_, _} ->
        :fail
    end
  end

# ej cons för datastrukturerna
  def eval_match({:cons, p1, p2}, {str1, str2}, env) do
    case eval_match(p1, str1, env) do
      :fail ->
        :fail
      {:ok, env2} ->
        eval_match(p2, str2, env2)
    end
  end

  def eval_match(_, _, _) do
    :fail
  end

  def eval_seq([exp], env) do
    eval_expr(exp, env)
  end

  def eval_seq([{:match, pattern, exp} | rest], env1) do
    case eval_expr(exp, env1) do
      :error ->
        :error
      {:ok, str} ->
        vars = extract_vars(pattern, [])
        env2 = Env.remove(vars, env1)

        case eval_match(pattern, str, env2) do
          :fail ->
            :error
          {:ok, env} ->
            eval_seq(rest, env)
        end
    end
  end

  def eval(seq) do eval_seq(seq, []) end

  def extract_vars({:var, var}, vars) do [var | vars] end

  def extract_vars({:cons, {:var, var1}, {:var, var2}}, vars) do [var1 | [var2 | vars]] end

  def extract_vars({:cons, {:var, var}, :ignore}, vars) do [var | vars] end

  def extract_vars({:cons, :ignore, {:var, var}}, vars) do [var | vars] end

  def extract_vars(_, vars) do vars end

end
