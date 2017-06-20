class Node
  attr_reader :score, :title
  attr_accessor :left, :right

  def initialize(score, title)
    @score = score
    @title = title
    @left  = nil
    @right = nil
  end
end
