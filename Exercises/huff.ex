defmodule Huffman do

  def sample do
    'hello'
  end

  def text()  do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def test do
    sample = sample()
    tree = tree(sample)
    encode = encode_table(tree)
    #decode = decode_table(tree)
    #text = text()
    #seq = encode(text, encode)
    #decode(seq, decode)
  end

  def tree(sample) do
    freq = freq(sample)
    sorted_freq = Enum.sort(freq, fn({_, x}, {_, y}) -> x<y end)
    {tree, freq} = huffman(freq)
    tree
  end

  def huffman([final | []]) do final end
  def huffman([{c1, f1}, {c2, f2} | tail]) do
    huffman(insert(tail, {c1, c2}, f1 + f2))
  end

  def insert([], c2, f2) do [{c2, f2}] end
  def insert([{c1, f1} | t], c2, f2) do
    cond do
      f2 > f1 -> [{c1, f1} | insert(t, c2, f2)]
      true -> [{c1, f1}, {c2, f2} | t]
    end
  end

  def freq(sample) do freq(sample, []) end

  def freq([], freq) do freq end

  def freq([char | rest], freq) do
    {f, rem} = count(char, rest)
    freq(rem, [f | freq])
  end

  def count(char, rest) do count(char, rest, 1, []) end
  def count(char, [], n, rem) do {{char, n}, rem} end
  def count(char, [char | t], n, rem) do count(char, t, n + 1, rem) end
  def count(char, [h | t], n, rem) do count(char, t, n, [h | rem]) end


  def encode_table(tree) do encode_table(tree, [], []) end
  def encode_table({left, right}, acc, path) do
    left = encode_table(left, acc, [0 | path])
    right = encode_table(right, left, [1 | path])
  end

  def encode_table(char, acc, path) do [{char, Enum.reverse(path)} | acc] end

  # Traverse the Huffman tree and build a binary encoding
  # for each character.
  def codes({a, b}, sofar) do
    as = codes(a, [0 | sofar])
    bs = codes(b, [1 | sofar])
    as ++ bs
  end
  def codes( a, code) do
    [{a, Enum.reverse(code)}]
  end


    # This is from github

    # Build the encoding table.
  def encode_table2(tree) do
    #codes(tree, [])
    # codes_better(tree, [], [])
    Enum.sort( codes_better(tree, [], []), fn({_,x},{_,y}) -> length(x) < length(y) end)
  end

  ## A better travering of the tree

  def codes_better({a, b}, sofar, acc) do
    left = codes_better(a, [0 | sofar], acc)
    codes_better(b, [1 | sofar], left)
  end
  def codes_better(a, code, acc) do
    [{a, Enum.reverse(code)} | acc]
  end



  ## An alternative way of representing the encode table.

  def encode_tuple(tree) do
    codes = codes(tree, [])
    sorted = Enum.sort(codes, fn({x,_}, {y,_}) ->  x < y end)
    extended = extend_codes(sorted, 0)
    List.to_tuple(extended)
  end

  def extend_codes([], _) do [] end
  def extend_codes([{n,code}|rest], n) do [code | extend_codes(rest, n+1)] end
  def extend_codes(codes, n) do [ [] | extend_codes(codes, n+1)] end

  def encode_tuple([], _), do: []
  def encode_tuple([char | rest], table) do
     code = elem(table, char)
     code ++ encode_tuple(rest, table)
  end

  ## An improvement where we do not waste any stack space

  #def encode_tuple(text, table) do
  #   encode_tuple(text, table, [])
  #end

  def encode_tuple([], _, acc) do flattenr(acc, []) end

  def encode_tuple([char | rest], table, acc) do
    code = elem(table, char)
    encode_tuple(rest, table, [code | acc])
  end

  def flattenr([], acc) do acc end
  def flattenr([code|rest], acc) do
    # this could further be improved if we didn't reverse the code
    flattenr(rest, code ++ acc)
  end

  # if code was stored in the reveresed order
  def add([], acc) do acc end
  def add([b|rest], acc) do
    add(rest, [b|acc])
  end






  # Parse a string of text and encode it with the
  # previously generated encoding table.
  def encode([], _), do: []
  def encode([char | rest], table) do
    {_, code} = List.keyfind(table, char, 0)
    code ++ encode(rest, table)
  end







  # Decode a string of text using the same encoding
  # table as above. This is a shortcut and an
  # unrealistic situation.

  def decode_table(tree), do: codes(tree, [])

  def decode([], _), do: []
  def decode(seq, table) do
    {char, rest} = decode_char(seq, 1, table)
    [char | decode(rest, table)]
  end

  def decode_char(seq, n, table) do
    {code, rest} = Enum.split(seq, n)
    case List.keyfind(table, code, 1) do
      {char, _} ->
        {char, rest}

      nil ->
        decode_char(seq, n + 1, table)
    end
  end








  # # The decoder using the tree. This is a more realistic
  # # solution.

   # def decode_table(tree) do tree end

   # def decode(seq, tree) do
   #   decode(seq, tree, tree)
   # end

  def decode([], char, _)  do
    [char]
  end

  def decode([0 | seq], {left, _}, tree) do
    decode(seq, left, tree)
  end
  def decode([1 | seq], {_, right}, tree) do
    decode(seq, right, tree)
  end
  def decode(seq, char, tree) do
    [char | decode(seq, tree, tree)]
  end
end
