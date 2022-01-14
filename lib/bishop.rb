class Bishop < Piece
  def initialize(color, position)
    super
    @symbol = @color == 'white' ? ' ♗ ' : ' ♝ '
  end

  def return_valid(board)
    row, col = @position
    movement(row, col, board)
    @valid_movements
  end

  def movement(row, col, board)
    directions = [[-1, -1], [-1, 1], [1, 1], [1, -1]]
    directions.each { |cell| find_edge(row, col, cell, board) }
  end
end