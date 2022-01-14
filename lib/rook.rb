class Rook < Piece
  def initialize(color, position)
    super
    @symbol = @color == 'white' ? ' ♖ ' : ' ♜ '
  end

  def movement(row, col, board)
    directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
    directions.each { |cell| find_edge(row, col, cell, board)}
  end
end