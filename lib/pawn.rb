class Pawn < Piece
  def initialize(color)
    super
    @symbol = @color == 'white' ? ' ♙ ' : ' ♟︎ '
    @first_move = true
  end
end