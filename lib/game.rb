class Game
  require_relative 'board'
  require_relative 'player'

  def initialize(player1 = nil, player2 = nil)
    @player1 = set_player_name(player1)
    @player2 = set_player_name(player2)
    @board = Board.new
  end
end