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

  def select_piece(position, board)
    begin
      position = position.split(',').map(&:to_i)
    rescue NoMethodError
      puts 'Input a value in the format number,number. E.g. 2,7'
    end
    piece = board.return_piece(position)
    return 'No piece found, please try again.' && select_piece(gets.chomp, board) if piece.nil?
    
    piece
  end


end