class Knight < Piece
  def initialize(color)
    super
    @symbol = @color == 'white' ? ' ♘ ' : ' ♞ '
  end

  def movement(row, col, board)
    moves = []
    places = [[-1, -2], [-2, -1], [-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2]]
    places.each do |cell|
      x, y = cell
      next if (row + x).negative? || (col + y).negative? || (row + x) > 7 || col + y > 7

      new_position = [row + x, col + y]
      moves += [new_position] unless same_color?(new_position, board)
    end
    moves
  end
end