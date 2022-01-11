class Game
  require_relative 'board'
  require_relative 'player'

  def initialize(player1 = nil, player2 = nil)
    @player1 = Player.new('white', player1)
    @player2 = Player.new('black', player2)
    @board = Board.new
  end
end