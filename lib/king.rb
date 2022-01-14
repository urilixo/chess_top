class King < Piece
  def initialize(color, position)
    super
    @symbol = @color == 'white' ? ' ♔ ' : ' ♚ '
  end
end