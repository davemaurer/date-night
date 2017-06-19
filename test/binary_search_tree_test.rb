require './lib/binary_search_tree'

describe BinarySearchTree do
  it "has a head node initially set to nil" do
    bs = BinarySearchTree.new
    expect(bs.head).to be nil
  end
end
