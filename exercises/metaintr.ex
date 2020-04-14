defmodule Env do
  @type value :: any()
  @type key :: atom()
  @type env :: [{key, value}]

  @spec add(key, value, env) :: env

  def new() do [] end

  def add(id, str, env) do
    [{id, str} | env]
  end

  def lookup(id, [{envid, envstr} | _]) when id == envid do
    {envid, envstr}
  end

  def lookup(id, [_ | envt]) do
    lookup(id, envt)
  end

  def lookup(_, []) do nil end

  def remove([idh | idt], env) do
    case lookup(idh, env) do
      {idh, _} ->
                env = removebind(idh, env)
                remove(idt,env)
      nil -> remove(idt, env)
    end
  end
  def remove([], env) do env end 

  def removebind(id, [{envid, _} | envt]) when id == envid do
    envt
  end
  def removebind(id, [envh | envt]) do
    [envh | removebind(id, envt)]
  end
end

defmodule Eager do
  def eval(x) do
    eval_seq(x, Env.new())
  end

  def eval_expr({:atm, id}, _) do {:ok, id} end

  def eval_expr({:var, id}, env) do
    case Env.lookup(id, env) do
      nil -> :error
      {_, str} -> {:ok, str}
    end
  end

  def eval_expr({:cons, hp, tp}, env) do
    case eval_expr(hp, env) do
      :error -> :error
      {:ok, str} ->
        case eval_expr(tp, env) do
          :error -> :error
          {:ok, ts} -> {:ok, {str, ts}}
        end
    end
  end

  def eval_expr({:case, expr, cls}, env) do
    case eval_expr(expr, env) do
      :error -> :error
      {_, str} -> eval_cls(cls, str, env)
    end
  end

  def eval_cls([], _, _, _) do
    :error
  end

  def eval_cls([{:clause, ptr, seq} | cls], str, env) do
    case eval_match(ptr, str, env) do
      :fail -> eval_cls(cls, str, env)
      {:ok, env} -> eval_seq(seq, env)
    end
  end

  def eval_match(:ignore, _, env) do
    {:ok, env}
  end

  def eval_match({:atm, id}, id, env) do
    {:ok, env}
  end

  def eval_match({:var, id}, str, env) do
    case Env.lookup(id, env) do
      nil -> {:ok, Env.add(id, str, env)}
      {_, ^str} -> {:ok,  env}
      {_, _} -> :fail
    end
  end

  def eval_match({:cons, hp, tp},  {str1, str2} ,env) do
    case eval_match(hp, str1, env) do
      :fail -> :fail
      {:ok, nenv} -> eval_match(tp, str2, nenv)
    end
  end


  def eval_match(_, _, _) do :fail end

  def eval_seq([{:match, hp, tp}| rest], env)do
    case eval_expr(tp, env) do
      :error -> :fail
      {_, str} ->
        vars = extract_vars(hp)
        nenv = Env.remove(vars, env)
        case eval_match(hp,str,nenv) do
          :fail -> :error
          {:ok, nenv2} -> eval_seq(rest, nenv2)
        end
    end
  end

  def eval_seq([exp], env) do
    eval_expr(exp, env)
  end
  #test comment lmao xDDDDD
  def eval_seq([], env) do
    env
  end

  def extract_vars({:var, x}) do [x] end
  def extract_vars({:cons, :ignore, {:var, x}}) do [x] end
  def extract_vars({:coms, {:var, x}, :ignore}) do [x] end
  def edtract_vars({:coms, {:var, x}, {:var, y}}) do [x, y] end
  
end
