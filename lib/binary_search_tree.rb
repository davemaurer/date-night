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

  def include?(score, current=@head)
    return true if score == current.score
    return false if score < current.score && current.left.nil?
    return false if score > current.score && current.right.nil?
    # return true if score == current.left.score || score == current.right.score
    continue_search(score, current)
  end

  def continue_search(score, current)
    if score < current.score
      include?(score, current.left)
    else
      include?(score, current.right)
    end
  end

  def increase_depth(score, current, depth)
    if score < current.score
      depth_of?(score, current.left, depth)
    else
      depth_of?(score, current.right, depth)
    end
  end

  def depth_of?(score, current=@head, depth=0)
    return depth if score == current.score
    return nil if score < current.score && current.left.nil?
    return nil if score > current.score && current.right.nil?
    # return depth + 1 if score == current.left.score || score == current.right.score
    increase_depth(score, current, depth + 1)
  end

  def max
    return "This list is empty." unless @head
    current = @head
    current = current.right until current.right.nil?
    Hash[current.title, current.score]
  end

  def min
    return "This list is empty." unless @head
    current = @head
    current = current.left until current.left.nil?
    Hash[current.title, current.score]
  end

  def sort
    return "This list is empty." unless @head
    current = @head
    movies = [min]
    latest_score = movies.last.score
    if current.left
      current = current.left until current.left.score
    end
    movies
  end

end
