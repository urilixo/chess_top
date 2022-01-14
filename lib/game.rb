class Game
  require_relative 'board'
  require_relative 'player'
  attr_reader :player1, :player2, :board, :current_turn

  def initialize(player1 = nil, player2 = nil)
    @player1 = Player.new('white', player1)
    @player2 = Player.new('black', player2)
    @board = Board.new
    @current_turn = @player1
  end

  def end_turn
    @current_turn == @player1 ? @player2 : @player1
  end

  def make_move
    player = @player1.color == @current_turn ? @player1 : @player2
    puts "#{player.name}'s turn, pick a piece to move:"
    selected_piece = @current_turn.select_piece(gets.chomp, board)
    starting_pos = selected_piece.position
    moves = return_valid(selected_piece)
    puts 'Valid movements are: '
    moves.each { |move| p move}
    valid_move(selected_piece)
    @board.move_piece(starting_pos, selected_piece)
  end

  def valid_move(piece)
    puts 'Pick a place to move'
    input = gets.chomp
    input = input.split(',').map(&:to_i)
    unless piece.valid_movements.include?(input)
      puts 'Invalid move, please try again'
      return valid_move(piece)
    end
    piece.position = input
  end

  def update_all_movements
    @board.board.each do |cell|
      next unless cell.is_a?(Piece)

      cell.return_valid(@board.board)
    end
  end

  def return_valid(piece)
    #binding.pry
    piece.return_valid(@board.board)
  end
end