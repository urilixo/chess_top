class Bishop < Piece
  def initialize(color)
    super
    @symbol = @color == 'white' ? ' ♗ ' : ' ♝ '
  end

  def movement(row, col, board)
    moves = []
    directions = [[-1, -1], [-1, 1], [1, 1], [1, -1]]
    directions.each { |cell| moves += find_edge(row, col, cell, board) unless find_edge(row, col, cell, board).nil? }
    moves
  end
end