class Knight < Piece
  def initialize(color, position)
    super
    @symbol = @color == 'white' ? ' ♞ ' : ' ♘ '
  end

  def return_valid(board)
    row, col = @position
    valid_moves = l_shape(row, col, board)
    @valid_movements = valid_moves
  end

  def l_shape(row, col, board)
    valid = []
    places = [[-1, -2], [-2, -1], [-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2]]
    places.each do |cell|
      x, y = cell
      next if (row + x).negative? || (col + y).negative? || (row + x) > 7 || col + y > 7

      new_position = [row + x, col + y]
      valid << new_position unless same_color?(new_position, board)
    end
    valid
  end
end