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
  def initialize(_start_point = [0, 1])
    initialize_board
  end

  def test
    @board[33].print_neighbors
  end

  private

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

x.test
