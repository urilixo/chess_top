class Player
  require_relative 'board'
  def initialize(color, name = nil)
    @player_name = player_name(name)
    new_name if player_name.nil?
    @color = color
  end

  def player_name(name)
    if name.nil?
      puts 'Please type player name: '
      return gets.chomp if name.nil?
    end
    name
  end

  def select_piece(position)
  end


end