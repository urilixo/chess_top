class Player
  require_relative 'board'
  attr_reader :name, :color

  def initialize(color, name = nil)
    @name = player_name(name)
    @color = color
  end

  def player_name(name)
    if name.nil?
      puts 'Please type player name: '
      return gets.chomp
    end
    name
  end

  def select_piece(position)
  end


end