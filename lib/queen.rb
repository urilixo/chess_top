class Queen < Piece
  def initialize(color, position)
    super
    @symbol = @color == 'white' ? ' ♕ ' : ' ♛ '
  end
end

