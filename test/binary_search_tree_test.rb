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
    expect(bst.head.title).to eq "Scary Movie"
    expect(first).to  eq 0
    expect(bst.head.left.title).to eq "Young Guns Two"
    expect(second).to eq 1
  end
end
