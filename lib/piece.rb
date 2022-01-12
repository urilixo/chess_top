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
end