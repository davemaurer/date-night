require './lib/binary_search_tree'

describe BinarySearchTree do
  it "has a head node initially set to nil" do
    bst = BinarySearchTree.new
    expect(bst.head).to eq nil
  end

  it "can insert a node" do
    bst    = BinarySearchTree.new
    result = bst.insert(60, "Scary Movie")
    expect(bst.head.title).to eq "Scary Movie"
    expect(result).to eq 0
  end

  it "can insert two nodes" do
    bst    = BinarySearchTree.new
    first  = bst.insert(60, "Scary Movie")
    second = bst.insert(30, "Young Guns Two")

    expect(bst.head.title).to      eq "Scary Movie"
    expect(bst.head.left.title).to eq "Young Guns Two"
    expect(first).to               eq 0
    expect(second).to              eq 1
  end

  it "can insert more than two nodes" do
    bst     = BinarySearchTree.new
    first   = bst.insert(60, "Scary Movie")
    second  = bst.insert(30, "Young Guns Two")
    third   = bst.insert(90, "Deadpool")
    fourth  = bst.insert(70, "Finding Nemo")
    fifth   = bst.insert(95, "Star Wars A New Hope")
    sixth   = bst.insert(10, "Out of Africa")
    seventh = bst.insert(100, "Happy Gilmore")
    last    = bst.head.right.right.right.title

    expect(bst.head.left.title).to        eq "Young Guns Two"
    expect(bst.head.right.title).to       eq "Deadpool"
    expect(bst.head.left.left.title).to   eq "Out of Africa"
    expect(bst.head.right.left.title).to  eq "Finding Nemo"
    expect(bst.head.right.right.title).to eq "Star Wars A New Hope"
    expect(last).to                       eq "Happy Gilmore"
    expect(fourth).to                     eq 2
    expect(sixth).to                      eq 2
    expect(seventh).to                    eq 3
  end

  it "determines if a movie is in the tree, by score" do
    bst = BinarySearchTree.new
    bst.insert(60, "Scary Movie")
    bst.insert(30, "Young Guns Two")
    bst.insert(70, "Deadpool")
    bst.insert(65, "Finding Nemo")
    bst.insert(95, "Star Wars A New Hope")
    bst.insert(100, "Happy Gilmore")

    expect(bst.include?(10)).to eq false
    expect(bst.include?(95)).to eq true
    expect(bst.include?(68)).to eq false
    expect(bst.include?(63)).to eq false
    expect(bst.include?(1)).to  eq false
    expect(bst.include?(99)).to eq false
  end

  it "finds the depth of a node, by score" do
    bst = BinarySearchTree.new
    bst.insert(60, "Scary Movie")
    bst.insert(30, "Young Guns Two")
    bst.insert(70, "Deadpool")
    bst.insert(65, "Finding Nemo")
    bst.insert(95, "Star Wars A New Hope")
    bst.insert(96, "Happy Gilmore")
    bst.insert(100, "Star Wars A New Hope")

    expect(bst.depth_of?(1)).to   eq nil
    expect(bst.depth_of?(10)).to  eq nil
    expect(bst.depth_of?(99)).to  eq nil
    expect(bst.depth_of?(105)).to eq nil
    expect(bst.depth_of?(60)).to  eq 0
    expect(bst.depth_of?(30)).to  eq 1
    expect(bst.depth_of?(70)).to  eq 1
    expect(bst.depth_of?(65)).to  eq 2
    expect(bst.depth_of?(95)).to  eq 2
    expect(bst.depth_of?(96)).to  eq 3
    expect(bst.depth_of?(100)).to eq 4
  end

  it "finds the highest scoring movie" do
    bst = BinarySearchTree.new
    bst.insert(60, "Scary Movie")
    bst.insert(30, "Young Guns Two")
    bst.insert(70, "Deadpool")
    bst.insert(65, "Finding Nemo")
    bst.insert(100, "Star Wars A New Hope")

    expect(bst.max).to eq({ "Star Wars A New Hope" => 100 })
  end

  it "tells you if the list is empty when looking for highest scoring movie" do
    bst = BinarySearchTree.new
    expect(bst.max).to eq "This list is empty."
  end

  it "finds highest scoring movie if it's the head" do
    bst = BinarySearchTree.new
    bst.insert(60, "Scary Movie")
    bst.insert(30, "Young Guns Two")

    expect(bst.max).to eq({ "Scary Movie" => 60 })
  end

  it "finds the lowest scoring movie" do
    bst = BinarySearchTree.new
    bst.insert(60, "Scary Movie")
    bst.insert(30, "Young Guns Two")
    bst.insert(10, "Out of Africa")
    bst.insert(70, "Deadpool")
    bst.insert(65, "Finding Nemo")
    bst.insert(100, "Star Wars A New Hope")

    expect(bst.min).to eq({"Out of Africa" => 10})
  end

  it "tells you if the list is empty when looking for the lowest scoring movie" do
    bst = BinarySearchTree.new
    expect(bst.max).to eq "This list is empty."
  end

  it "finds lowest scoring movie if it's the head" do
    bst = BinarySearchTree.new
    bst.insert(30, "Young Guns Two")
    bst.insert(65, "Finding Nemo")

    expect(bst.min).to eq({ "Young Guns Two" => 30 })
  end

  it "returns a sorted list of all movies" do
    bst = BinarySearchTree.new
    bst.insert(60, "Scary Movie")
    bst.insert(30, "Young Guns Two")
    bst.insert(10, "Out of Africa")
    bst.insert(70, "Deadpool")
    bst.insert(65, "Finding Nemo")
    bst.insert(100, "Star Wars A New Hope")

    expect(bst.sort).to eq [{ "Out of Africa" => 10 },
                            { "Young Guns Two" => 30 },
                            { "Scary Movie" => 60 },
                            { "Finding Nemo" => 65 },
                            { "Deadpool" => 70 },
                            { "Star Wars A New Hope" => 100}
                           ]
  end

  it "returns a sorted list if only one node is present" do
    bst = BinarySearchTree.new
    bst.insert(60, "Scary Movie")

    expect(bst.sort).to eq [{ "Scary Movie" => 60 }]
  end

end
