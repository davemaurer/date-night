class BinarySearchTree
  attr_reader :head

  def initialize
    @head = nil
  end

  def insert(score, title)
    @head = Node.new(score, title) if !@head
  end
end
