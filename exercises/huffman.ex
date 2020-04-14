defmodule H do

  def sample() do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def text() do
    'this is something that we should encode'
  end

  def test(sample) do
    tree = tree(sample)
    IO.inspect(tree)
    encode_table = encode_table_real(tree)
    IO.inspect(encode_table)
    encoding = encode(sample, encode_table)
    IO.inspect(encoding)
    _decoded = decode_all(encoding, tree)
  end

  def tree(sample) do
    freq = freqs(sample)
    huffman(freq)
  end

  def huffman([{:node, e1, v1, left1, right1}, {:node, e2, v2, left2, right2}| rest]) do
    huffman(insertsorted({:node, :nil, v1 + v2, {:node, e1, v1, left1, right1}, {:node, e2, v2, left2, right2}}, rest))
  end
  def huffman([l]) do l end

########################################reinserting new node into huffman tree###################
  def insertsorted({:node, e, freq, left, right}, [{:node, de, dfreq, dleft, dright}| tail])
  when dfreq < freq do
    [{:node, de, dfreq, dleft, dright} | insertsorted({:node, e, freq, left, right}, tail)]
  end
  def insertsorted({:node, e, freq, left, right}, [{:node, de, dfreq, dleft, dright}| tail]) do
    [{:node, e, freq, left, right} | [{:node, de, dfreq, dleft, dright} | tail]]
  end
  def insertsorted({:node, e, freq, left, right}, []) do
    [{:node, e, freq, left, right}]
  end
########################################insertsorted end#########################################

  def encode_table({:node, ascii, _, left, right}, encoding, list) when ascii != :nil do
    encode_table(left, [0 | encoding], encode_table(right, [1 | encoding], [ {ascii, encoding}  | list]))  
  end
  def encode_table({:node, :nil, _, left, right}, encoding, list) do
    encode_table(left, [0 | encoding],encode_table(right, [1 | encoding],list))
  end  
  def encode_table(:nil,  _, l) do l end
  def encode_table(node) do encode_table(node, [], []) end
    
  def reverse(l) do reverse(l, []) end
  def reverse([] ,r) do r end
  def reverse([h|t] ,r) do
    reverse(t, [h | r])
  end

  def listbreaker([{ascii, encoding} | rest]) do
    [{ascii, reverse(encoding)} | listbreaker(rest)]
  end
  def listbreaker([]) do [] end

###########################insert huffman tree in this to get correct table####################
  def encode_table_real(x) do
    listbreaker(encode_table(x))
  end
###########################end##################################################################

  def encode([char | rest], table) do
    append(enclkup(char, table), encode(rest, table))
  end
  def encode([] , _) do [] end

  def enclkup(char, [{ascii, encoding} | _])when char == ascii do
    encoding
  end
  def enclkup(char, [{_, _} | rest]) do
    enclkup(char, rest)
  end
  def enclkup(_, []) do [] end

  def append([], y) do y end
  def append([h | t], y) do
    [h | append(t, y)]
  end

  def decode([h | t], {:node, ascii, _, left ,right}) when ascii == :nil do
    case h do
      1 -> decode(t, right)
      0 -> decode(t, left)
    end
  end
  def decode(encoding, {:node, ascii, _, _, _}) do
    {ascii , encoding} 
  end
  def decode([], _) do [] end

  def decode_all([], _) do [] end
  def decode_all(encoding, tree) do
    {ascii, remenc} = decode(encoding,tree)
    [ascii | decode_all(remenc,tree)] 
  end

  def freq(sample) do
    freq(sample, [] , :nil)
  end

  def freq([], [char | _], x) do
    x = add(char, 0 , :nil)
  end

  def freq([char | rest], freqz , x) do
    x = add(char, 1, freq(rest, [char | freqz], x))
  end

  def freqs(sample) do
    isort(postfix(freq(sample)))
  end


########################symbol tree for frequency list############################################

  def add(key, value, :nil) do {:node, key, value, :nil, :nil} end
  def add(key, value, {:node, diffkey, diffvalue, :nil, :nil}) when key < diffkey do
    {:node, diffkey, diffvalue, {:node, key, value, :nil, :nil}, :nil}
  end
  def add(key, _, {:node, key, diffvalue, left, right}) do
    {:node, key, diffvalue + 1 , left, right}
  end

  def add(key, value, {:node, diffkey, diffvalue, :nil, :nil}) do
    {:node, diffkey, diffvalue, :nil, {:node, key, value, :nil, :nil}}
  end
  def add(key, value, {:node, diffkey, diffvalue, left, right}) when key < diffkey do
    {:node, diffkey, diffvalue, add(key, value, left), right}
  end
  def add(key, value, {:node, diffkey, diffvalue, left, right}) do
    {:node, diffkey, diffvalue, left, add(key, value, right)}
  end
################################symbol tree end ##################################################
########################tree traversal############################################################

  def postfix(node) do postfix(node, []) end
  def postfix(:nil, l) do l end
  def postfix({:node, key, value, left, right}, l) do
    postfix(left,postfix(right,[{:node, key, value, :nil, :nil}| l])) 
  end

#######################tree traversal end########################################################
###################################insertion sort################################################
  def insert({:node, key, value, :nil, :nil}, []) do [{:node, key, value, :nil, :nil}] end
  def insert({:node, key, value, :nil, :nil}, [{:node, diffk, diffv, :nil, :nil}]) do
    case value do
      value when value > diffv -> [{:node, diffk, diffv, :nil, :nil} | [{:node, key, value, :nil, :nil}]]
      _ -> [{:node, key, value, :nil, :nil} | [{:node, diffk, diffv, :nil, :nil}]]
    end
  end

  def insert({:node, key, value, :nil, :nil}, [{:node, diffk, diffv, :nil, :nil} | t]) do
    case value do
      value when value > diffv ->[{:node, diffk, diffv, :nil, :nil} | insert({:node, key, value, :nil, :nil} , t)]
      _ -> [{:node, key, value, :nil, :nil} | [{:node, diffk, diffv, :nil, :nil} | t]]
    end
  end

  #insertion sort
  def isort ([]) do [] end
  def isort ([a]) do [a] end
  def isort ([{:node, key, value, :nil, :nil} | t]) do
    insert({:node, key, value, :nil, :nil}, isort(t))
  end
###############################Insertion sort end#################################################
end
