class Game
  require_relative 'board'
  require_relative 'player'
  attr_reader :player1, :player2, :board, :current_turn

  def initialize(player1 = nil, player2 = nil)
    @player1 = Player.new('white', player1)
    @player2 = Player.new('black', player2)
    @board = Board.new
    @current_turn = 'white'
  end

  def end_turn
    @current_turn == 'white' ? 'black' : 'white'
  end
end