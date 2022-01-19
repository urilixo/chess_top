# frozen_string_literal: true

class Piece
  attr_accessor :color, :valid_movements
  attr_reader :symbol

  def initialize(color)
    @color = color
    @valid_movements = []
    @starting_position = true
  end

  def same_color?(position, board)
    x, y = position
    return unless board[x][y].is_a?(Piece)

    board[x][y].color == @color
  end

  def return_valid(board)
    row, col = @position
    movement(row, col, board)
    @valid_movements
  end

  def find_edge(row, col, direction, board, moves = [])
    x, y = direction
    row += x
    col += y
    return if row.negative? || col.negative? || row > 7 || col > 7
    return if same_color?([row, col], board)

    @valid_movements << [row, col]
    find_edge(row, col, direction, board, moves) unless board[row][col].is_a?(Piece)
  end
end
