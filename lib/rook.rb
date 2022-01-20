class Rook < Piece
  attr_reader :first_move

  def initialize(color)
    super
    @symbol = @color == 'white' ? ' ♖ ' : ' ♜ '
    @first_move = true
  end

  def movement(row, col, board)
    @starting_position = false
    moves = []
    directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
    directions.each { |cell| moves += find_edge(row, col, cell, board) unless find_edge(row, col, cell, board).nil?}
    @first_move = false
    moves
  end
end