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
    bst    = BinarySearchTree.new
    first  = bst.insert(60, "Scary Movie")
    second = bst.insert(30, "Young Guns Two")
    third  = bst.insert(90, "Deadpool")
    fourth = bst.insert(70, "Finding Nemo")
    fifth  = bst.insert(100, "Star Wars A New Hope")
    sixth  = bst.insert(10, "Out of Africa")
    expect(bst.head.left.title).to        eq "Young Guns Two"
    expect(bst.head.right.title).to       eq "Deadpool"
    expect(bst.head.left.left.title).to   eq "Out of Africa"
    expect(bst.head.right.left.title).to  eq "Finding Nemo"
    expect(bst.head.right.right.title).to eq "Star Wars A New Hope"
    expect(fourth).to                     eq 2
    expect(sixth).to                      eq 2
  end
end
