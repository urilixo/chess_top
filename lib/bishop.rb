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

  def find_edge(row, col, direction, board, moves = [])
    x, y = direction
    row += x
    col += y
    return if row.negative? || col.negative? || row > 7 || col > 7
    return if same_color?([row, col], board)

    @valid_movements << [row, col]
    #binding.pry
    find_edge(row, col, direction, board, moves) unless board[row][col].is_a?(Piece)
  end
end