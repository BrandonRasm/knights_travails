# node class for a knight that stores its coordinates on the board and its immediate neighbors as pointers
class NodeKnight
  attr_accessor :coordinates
  attr_reader :neighbors

  def initialize(coordinates)
    @coordinates = coordinates
    @neighbors = []
  end

  def add_neighbor(node)
    return raise 'duplicate neighbord!!!! these damned clones' if @neighbors.include?(node)
    return raise "too many neighbors!!! it's getting crowded" if @neighbors.length >= 8

    @neighbors << node
  end

  def print_neighbors
    puts "#{coordinates} neighbors are:"
    @neighbors.each do |node|
      p node.coordinates
    end
  end
end

# class for a Knight in chess
class Knight
  def initialize()
    initialize_board
    @counter = 0
  end

  def test
    @board[33].print_neighbors
  end

  def knight_moves(start_point,end_point)
    start_node = find_node(start_point)
    end_node = find_node(end_point)
    queue = Queue.new
    steps = knight_moves_recursive([start_node,[]],end_node,queue)
    puts @counter
    puts "You made it in #{steps.length - 1} moves! Here's your path:"
    steps.each {|step| p step}
  end

  private

  def knight_moves_recursive(lineage,end_node,queue)
    @counter += 1
    start_node = lineage[0]
    parents = lineage[1].clone << start_node.coordinates
    return parents << end_node.coordinates if start_node.neighbors.include?(end_node)

    start_node.neighbors.each {|node| queue << [node,parents]}
    knight_moves_recursive(queue.pop,end_node,queue)
  end

  def initialize_board
    make_board_nodes
    assign_node_neighbors
  end

  def make_board_nodes
    @board = []
    (0..7).each do |x|
      (0..7).each do |y|
        @board << NodeKnight.new([x, y])
      end
    end
  end

  def assign_node_neighbors
    knight_moves = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
    @board.each do |node|
      knight_moves.each do |offset|
        neighbor_position = [(node.coordinates[0] - offset[0]), (node.coordinates[1] - offset[1])]
        node.add_neighbor(find_node(neighbor_position)) if valid_position?(neighbor_position)
      end
    end
  end

  def find_node(coordinates)
    @board.each { |node| return node if node.coordinates == coordinates }
  end

  def valid_position?(position)
    position.each do |num|
      return false if num.negative? || num > 7
    end
    true
  end
end

x = Knight.new

x.knight_moves([3,3],[4,3])
