class Rook < Piece
  attr_accessor :first_move

  def initialize(color)
    super
    @symbol = @color == 'white' ? ' ♖ ' : ' ♜ '
    @first_move = true
  end

  def movement(row, col, board)
    moves = []
    directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
    directions.each { |cell| moves += find_edge(row, col, cell, board) unless find_edge(row, col, cell, board).nil?}
    moves
  end
end