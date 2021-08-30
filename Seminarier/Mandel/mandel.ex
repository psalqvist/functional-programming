defmodule Cmplx do

  def new(r,i) do {r, i} end

  def add({r1, i1}, {r2, i2}) do {r1+r2, i1+i2} end

  def sqr({r, i}) do {r*r - i*i, 2*r*i} end

  def abs({r, i}) do
    import :math, only: [sqrt: 1]
    sqrt((r*r+i*i))
  end

end

defmodule Brot do

  def mandelbrot(c, m) do
    z0 = Cmplx.new(0, 0)
    i = 0
    test(i, z0, c, m)
  end

  def test(i, z, c, m) do
    cond do
      i >= m -> 0
      Cmplx.abs(z) > 2 -> i
      true -> test(i+1, Cmplx.add(Cmplx.sqr(z), c), c, m)
    end

  end

end

defmodule Mandel do
  import Color, only: [convert: 2]
  def mandelbrot(width, height, x, y, k, max_depth) do
    trans = fn(w, h) ->
    Cmplx.new(x + k * (w - 1), y - k * (h - 1))
    end

    rows(width, height, trans, max_depth, [])
  end

  def rows(_, 0, _, _, rows) do rows end
  def rows(width, height, trans, max_depth, rows) do
    row = row(width, height, trans, max_depth, [])
    rows(width, height-1, trans, max_depth, [row|rows])
  end

  def row(0, _, _, _, row) do row end
  def row(width, height, trans, max_depth, row) do
    compl = trans.(width, height)
    depth = Brot.mandelbrot(compl, max_depth)
    color = Color.convert(depth, max_depth)
    row(width-1, height, trans, max_depth, [color | row])
  end

  def demo() do
    small(-2.6, 1.2, 1.2)
  end

  def small(x0, y0, xn) do
    width = 960
    height = 540
    depth = 64
    k = (xn - x0) / width
    image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
    PPM.write("small.ppm", image)
  end
end
