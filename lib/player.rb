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

  def parse_movement(position)
    keys = { 'a': 0, 'b': 1, 'c': 2, 'd': 3, 'e': 4, 'f': 5, 'g': 6, 'h': 7 }
    x, y = position.split('')
    x = keys[x.to_sym]
    y = y.to_i - 1
    [x, y]
  end

  def select_piece(board)
    movement = parse_movement(gets.chomp)
    validate_piece(movement, board)
  end

  def validate_piece(position, board)
    begin
      position = position.split(',').map(&:to_i)
    rescue NoMethodError
      puts 'Input a value in a format such as: a1, g7, h3'
    end
    piece = board.return_piece(position)
    if piece.nil? || piece.color != color
      puts 'No piece for this player at this position, please try again.'
      return select_piece(board)
    end
    [piece, position]
  end
end