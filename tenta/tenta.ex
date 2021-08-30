defmodule Tenta do
  def program() do
    {{:addi, 1, 0, 10},
     {:addi, 3, 0, 1},
     {:out, 3},
     {:addi, 1, 1, -1},
     {:addi, 4, 3, 0},
     {:add, 3, 2, 3},
     {:out, 3},
     {:beq, 1, 0, 3},
     {:addi, 2, 4, 0},
     {:beq, 0, 0, -6},
     {:halt}}
  end

  def test() do
    program = program()
    emul(program)
  end

  def emul(prog) do emul(prog, 0, [{0, 0}, {1, 0}, {2, 0}, {3, 0}, {4, 0}, {5, 0}], []) end

  def emul(prog, pc, regs, out) do
    instr = elem(prog, pc)
    case instr do
      {:halt} -> reverse(out)
      _ ->
        {pc_new, regs_new, out_new} = exe(instr, pc, regs, out)
        emul(prog, pc_new, regs_new, out_new)
    end
  end

  def reverse(list) do reverse(list, []) end
  def reverse([], acc) do acc end
  def reverse([h | t], acc) do
    reverse(t, [h | acc])
  end

  # add instr
  def exe({:add, d, reg1, reg2}, pc, regs, out) do
    v1 = get_reg(reg1, regs)
    v2 = get_reg(reg2, regs)
    regs_new = update_regs(d, v1+v2, regs)
    {pc+1, regs_new, out}
  end

  # addi instr
  def exe({:addi, d, reg1, imm}, pc, regs, out) do
    v1 = get_reg(reg1, regs)
    regs_new = update_regs(d, v1+imm, regs)
    {pc+1, regs_new, out}
  end

  # write to out
  def exe({:out, reg}, pc, regs, out) do
    v1 = get_reg(reg, regs)
    {pc+1, regs, [v1 | out]}
  end

  # branch if equal instr
  def exe({:beq, reg1, reg2, offset}, pc, regs, out) do
    v1 = get_reg(reg1, regs)
    v2 = get_reg(reg2, regs)
    cond do
      v1 == v2 -> {pc+offset, regs, out}
      true -> {pc+1, regs, out}
    end

  end

  def get_reg(reg, [{reg, value} | t]) do
    value
  end
  def get_reg(reg, [h | t]) do
    get_reg(reg, t)
  end

  def update_regs(_, _, []) do [] end
  def update_regs(reg, v1, [{reg, v2} | t]) do
    [{reg, v1} | t]
  end

  def update_regs(reg, v, [h | t]) do
    [h | update_regs(reg, v, t)]
  end
end
