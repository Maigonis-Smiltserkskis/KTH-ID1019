defmodule I do

##################################Insertion Sort###############################
  #insertion function for insertion sort
  def insert(e, []) do [e] end
  def insert(e, [h]) do
    case e do
      e when e > h -> [h | [e]]
      _ -> [e | [h]]
    end
  end

  def insert(e, [h | t]) do
    case e do
      e when e > h ->[h | insert(e , t)]
      _ -> [e | [h | t]]
    end
  end

  #insertion sort
  def isort ([]) do [] end
  def isort ([a]) do [a] end
  def isort ([h | t]) do
    insert(h, isort(t))
  end



##################################Merge Sort###################################
  
  #merge sort
  def msort(l) do
    case l do
      [x] -> [x]
      _ ->
          {a, b} = msplit(l, [], [])
          merge(msort(a), msort(b))
    end
  end
  
  #merges 2 sorted lists
  def merge([], a) do a end
  def merge(a, []) do a end
  def merge([h1 | t1], [h2 | t2]) do
    if h1 < h2 do
      [h1 | merge(t1,[h2 | t2])]
    else
      [h2 | merge([h1 | t1],t2)]
    end
  end
  
  #splits given list to 2 lists
  def msplit(l, a, b) do
    case l do
      [] -> {a, b}
      [x] -> {[x | a], b}
      [h1 | [h2 | t]] -> msplit(t, [h1 | a], [h2 | b])
    end
  end

##################################Quick Sort##################################

  #quick sort
  def qsort([]) do [] end
  def qsort([p | l]) do
    {a, b} = qsplit(p, l, [], [])
    small = qsort(a)
    large = qsort(b)
    append(small, [p | large])
  end
  
  #splits given list around pivot
  def qsplit(_, [], small, large) do {small, large} end
  def qsplit(p, [h | t], small, large) do
    if h < p do
      qsplit(p, t, [h | small], large)
    else
      qsplit(p, t, small, [h | large])
    end
  end
  
  #appends 2 lists
  def append(x, y) do
    case x do
      [] -> y
      [h | t] -> [h | append(t, y)]
    end
  end
  
end
