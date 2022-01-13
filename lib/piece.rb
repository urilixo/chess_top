# frozen_string_literal: true

class Piece
  attr_accessor :position, :color, :valid_movements
  attr_reader :symbol

  def initialize(color, position)
    @color = color
    @position = position
    @valid_movements = []
    @starting_position = true
  end

  def same_color?(position, board)
    x, y = position
    return unless board[x][y].is_a?(Piece)

    board[x][y].color == @color
  end
end
