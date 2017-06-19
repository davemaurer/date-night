require './lib/node'

describe Node do
  it "starts out with score, title, left and right" do
    node = Node.new(95, "Highlander")
    expect(node.score).to eq 95
    expect(node.title).to eq "Highlander"
    expect(node.left).to  eq nil
    expect(node.right).to eq nil
  end
end
