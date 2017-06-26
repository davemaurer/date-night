require './lib/binary_search_tree'

describe BinarySearchTree do
  it "has a head node initially set to nil" do
    bst = BinarySearchTree.new
    expect(bst.head).to eq nil
  end

  it "inserts one node" do
    bst    = BinarySearchTree.new
    result = bst.insert(60, "Scary Movie")

    expect(bst.head.title).to eq "Scary Movie"
    expect(result).to eq 0
  end

  it "inserts two nodes" do
    bst    = BinarySearchTree.new
    first  = bst.insert(60, "Scary Movie")
    second = bst.insert(30, "Young Guns Two")

    expect(bst.head.title).to      eq "Scary Movie"
    expect(bst.head.left.title).to eq "Young Guns Two"
    expect(first).to               eq 0
    expect(second).to              eq 1
  end

  it "inserts more than two nodes" do
    bst     = BinarySearchTree.new
    _       = bst.insert(60, "Scary Movie")
    _       = bst.insert(30, "Young Guns Two")
    _       = bst.insert(90, "Deadpool")
    first   = bst.insert(70, "Finding Nemo")
    _       = bst.insert(95, "Star Wars A New Hope")
    second  = bst.insert(10, "Out of Africa")
    third   = bst.insert(100, "Happy Gilmore")
    last    = bst.head.right.right.right.title

    expect(bst.head.left.title).to        eq "Young Guns Two"
    expect(bst.head.right.title).to       eq "Deadpool"
    expect(bst.head.left.left.title).to   eq "Out of Africa"
    expect(bst.head.right.left.title).to  eq "Finding Nemo"
    expect(bst.head.right.right.title).to eq "Star Wars A New Hope"
    expect(last).to                       eq "Happy Gilmore"
    expect(first).to                      eq 2
    expect(second).to                     eq 2
    expect(third).to                      eq 3
  end

  it "determines if a movie is in the tree, by score" do
    bst = setup_tree

    expect(bst.include?(10)).to eq true
    expect(bst.include?(95)).to eq true
    expect(bst.include?(68)).to eq false
    expect(bst.include?(63)).to eq false
    expect(bst.include?(1)).to  eq false
    expect(bst.include?(99)).to eq false
  end

  it "finds the depth of a node, by score" do
    bst = setup_tree

    expect(bst.depth_of?(1)).to   eq nil
    expect(bst.depth_of?(65)).to  eq nil
    expect(bst.depth_of?(99)).to  eq nil
    expect(bst.depth_of?(105)).to eq nil
    expect(bst.depth_of?(60)).to  eq 0
    expect(bst.depth_of?(30)).to  eq 1
    expect(bst.depth_of?(90)).to  eq 1
    expect(bst.depth_of?(70)).to  eq 2
    expect(bst.depth_of?(95)).to  eq 2
    expect(bst.depth_of?(100)).to eq 3
  end

  it "finds the highest scoring movie" do
    bst = setup_tree
    expect(bst.max).to eq({ "Happy Gilmore" => 100 })
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
    bst = setup_tree
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
    bst = setup_tree

    expect(bst.sort).to eq [{ "Out of Africa" => 10 },
                            { "Young Guns Two" => 30 },
                            { "Scary Movie" => 60 },
                            { "Finding Nemo" => 70 },
                            { "Deadpool" => 90 },
                            { "Star Wars A New Hope" => 95 },
                            { "Happy Gilmore" => 100 }
                           ]
  end

  it "returns a sorted list if only one node is present" do
    bst = BinarySearchTree.new
    bst.insert(60, "Scary Movie")

    expect(bst.sort).to eq [{ "Scary Movie" => 60 }]
  end

  it "tells you if the list is empty when sorting" do
    bst = BinarySearchTree.new
    expect(bst.sort).to eq "This list is empty."
  end

  it "inserts movies from a csv file" do
    bst = BinarySearchTree.new
    bst.load("test/movies.txt")

    expect(bst.head.left.title).to eq "Young Guns Two"
    expect(bst.head.right.title).to eq "Deadpool"
    expect(bst.head.left.left.title).to eq "Out of Africa"
    expect(bst.head.right.left.title).to eq "Finding Nemo"
    expect(bst.head.right.right.title).to eq "Star Wars A New Hope"
    expect(bst.head.right.right.right.title).to eq "Happy Gilmore"
  end

  it "evaluates its health" do
    bst = setup_tree

    expect(bst.health(0)).to eq [[60, 7, 100]]
    expect(bst.health(1)).to eq [[30, 2, 28], [90, 4, 57]]
  end

  it "counts child nodes including the starting node" do
    bst = setup_tree
    nodes_of_scary = bst.count_nodes(bst.head)
    nodes_of_nemo  = bst.count_nodes(bst.head.right.left)
    nodes_of_dead  = bst.count_nodes(bst.head.right.right)

    expect(nodes_of_scary).to eq 7
    expect(nodes_of_nemo).to  eq 1
    expect(nodes_of_dead).to  eq 2
  end

  it "finds a node by score" do
    bst = setup_tree
    find_nemo = bst.find_node(70)
    dead_node = bst.find_node(90)

    expect(find_nemo.title).to eq "Finding Nemo"
    expect(dead_node.title).to eq "Deadpool"
  end

  it "deletes nodes with no children" do
    bst = setup_tree
    expect(bst.head.right.left.score).to eq 70
    bst.remove(70)
    expect(bst.head.right.left).to eq nil
  end

  it "deletes nodes with children" do
  bst = setup_tree
  expect(bst.head.right.left.score).to eq 70
  bst.remove(90)
  expect(bst.head.right.score).to eq 95
  end

  private

  def setup_tree
    bst = BinarySearchTree.new
    bst.insert(60, "Scary Movie")
    bst.insert(30, "Young Guns Two")
    bst.insert(90, "Deadpool")
    bst.insert(70, "Finding Nemo")
    bst.insert(95, "Star Wars A New Hope")
    bst.insert(10, "Out of Africa")
    bst.insert(100, "Happy Gilmore")
    bst
  end

end
