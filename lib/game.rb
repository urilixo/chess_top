class Game
  require_relative 'board'
  require_relative 'player'

  def initialize(player1 = nil, player2 = nil)
    @player1 = player_name(player1)
    @player2 = player_name(player2)
    @board = Board.new
  end

  def player_name(name)
    if name.nil?
      puts 'Please type player name: '
      return gets.chomp if name.nil?
    end
    name
  end
end