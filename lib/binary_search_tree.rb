require 'node'

class BinarySearchTree
  attr_reader :head

  def initialize
    @head = nil
  end

  def insert(score, title)
    depth = 0
    if !@head
      @head = Node.new(score, title)
    else
      depth = place_node(score, title, 1)
    end
    depth
  end

  def place_node(score, title, depth)
    current = @head
    done = false
    until done
      if score < current.score
        if current.left.nil?
          current.left = Node.new(score, title)
          done = true
        else
          current = current.left
          depth += 1
        end
      elsif score > current.score
        if current.right.nil?
          current.right = Node.new(score, title)
          done = true
        else
          current = current.right
          depth += 1
        end
      end
    end
    depth
  end

end
