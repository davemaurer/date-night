require 'node'

class BinarySearchTree
  attr_reader :head

  def initialize
    @head = nil
  end

  def insert(score, title, depth=0)
    if !@head
      @head = Node.new(score, title)
    else
      depth = place_node(score, title, 1)
    end
    depth
  end

  def place_node(score, title, depth, current=@head)
    depth = insert_left(score, title, depth, current) if score < current.score
    depth = insert_right(score, title, depth, current) if score > current.score
    depth
  end

  def insert_left(score, title, depth, current)
    if current.left.nil?
      current.left = Node.new(score, title)
      depth
    else
      place_node(score, title, depth + 1, current.left)
    end
  end

  def insert_right(score, title, depth, current)
    if current.right.nil?
      current.right = Node.new(score, title)
      depth
    else
      place_node(score, title, depth + 1, current.right)
    end
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
    movies = format_health(depth, current, movies)
    health(depth, current.right, movies)
    movies
  end

  def format_health(depth, current, movies)
    if depth_of?(current.score) == depth
      total_count = count_nodes(@head)
      node_count = count_nodes(current)
      movies << [current.score, node_count,
        percentage_of_tree(total_count, node_count)]
    end
    movies
  end

  def count_nodes(current, nodes=[])
    return if current.nil?
    count_nodes(current.left, nodes)
    nodes << current.score
    count_nodes(current.right, nodes)
    nodes.length
  end

  def percentage_of_tree(total_count, node_count)
    (node_count.to_f / total_count.to_f * 100).to_i
  end

  def remove(score)
    to_remove = find_node(score)
    if to_remove
      if to_remove.left.nil? && to_remove.right.nil?
        delete_node(score)
      end
    end
  end

  def find_node(score, current=@head)
    return nil if current.nil?
    if score == current.score
      current
    elsif score < current.score
      find_node(score, current.left)
    elsif score > current.score
      find_node(score, current.right)
    end
  end

  def delete_node(score, current=@head)
    return nil if current.nil?
    if score < current.score
      if score == current.left.score
        current.left = nil
      else
        delete_node(score, current.left)
      end
    elsif score > current.score
      if score == current.right.score
        current.right = nil
      else
        delete_node(score, current.right)
      end
    end
  end

end
