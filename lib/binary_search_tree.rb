require 'node'

class BinarySearchTree
  attr_reader :head

  def initialize
    @head = nil
  end

  # def insert(score, title, current=@head, depth=0)
  #   if current.nil?
  #     current = Node.new(score, title)
  #     return depth
  #   end
  #   insert(score, title, current.left, depth + 1) if current.left && score < current.left.score
  #   insert(score, title, current.right, depth + 1) if current.right && score > current.right.score
  # end

  def insert(score, title, depth=0)
    if !@head
      @head = Node.new(score, title)
    else
      depth = place_node(score, title, 1)
    end
    depth
  end

  def place_node(score, title, depth, current=@head)
    if score < current.score
      if current.left.nil?
        current.left = Node.new(score, title)
        return depth
      else
        place_node(score, title, depth + 1, current.left)
      end
    elsif score > current.score
      if current.right.nil?
        current.right = Node.new(score, title)
        return depth
      else
        place_node(score, title, depth + 1, current.right)
      end
    end
  end

  # def place_node(score, title, depth)
  #   current = @head
  #   done = false
  #   until done
  #     if score < current.score
  #       if current.left.nil?
  #         current.left = Node.new(score, title)
  #         done = true
  #       else
  #         current = current.left
  #         depth += 1
  #       end
  #     elsif score > current.score
  #       if current.right.nil?
  #         current.right = Node.new(score, title)
  #         done = true
  #       else
  #         current = current.right
  #         depth += 1
  #       end
  #     end
  #   end
  #   depth
  # end

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

  def sort(current=@head, movies=[])
    return "This list is empty." unless current
    return if current.nil?
    sort(current.left, movies)
    movies << { current.title => current.score }
    sort(current.right, movies)
    movies
  end

  def load(file)
    File.open(file).readlines.each do |line|
      data = line.strip.split(", ", 2)
      insert(data[0].to_i, data[1])
    end
  end

  def health(depth, current=@head, movies=[])
    return if current.nil?
    health(depth, current.left, movies)
    if depth_of?(current.score) >= depth
    movies << [current.score, count_nodes(current), percentage_of_tree(current)]
    end
    health(depth, current.right, movies)
    movies
  end

  def count_nodes(depth)
    
  end

end
