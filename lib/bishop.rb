class Bishop < Piece
  def initialize(color, position)
    super
    @symbol = @color == 'white' ? ' ♗ ' : ' ♝ '
  end

  def return_valid(board)
    row, col = @position
    diagonal(row, col, board)
    @valid_movements
  end

  def diagonal(row, col, board)
    directions = [[-1, -1], [-1, 1], [1, 1], [1, -1]]
    directions.each { |cell| find_edge(row, col, cell, board) }
  end
end