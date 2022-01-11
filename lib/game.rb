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

  def make_move
    player = @player1.color == @current_turn ? @player1 : @player2
    puts "#{player.name}'s turn, pick a piece to move:"
    starting_pos = select_piece(gets.chomp)
    puts "Valid movements are: "
    puts "Pick a place to move"
    final_pos = valid_move(gets.chomp)
    @board.move_piece(starting_pos.position, final_pos)
  end

  def select_piece(position)
    piece = @board.return_piece(position)
    return puts 'No piece found, please try again.' and select_piece(gets.chomp) if piece.nil?

    @piece
  end

  def return_valid(piece)
    piece.return_valid(@board)
  end
end