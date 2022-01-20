class Game
  require_relative 'board'
  require_relative 'player'
  attr_reader :player1, :player2, :board, :current_turn

  def initialize(player1 = nil, player2 = nil, load: false)
    if load == true
      load_game
    else
      @player1 = Player.new('white', player1)
      @player2 = Player.new('black', player2)
      @board = Board.new
      @current_turn = @player1
    end
  end

  def save_game
    File.open('save_data.yaml', 'w') do |f|

      f.write(@player1.to_yaml)
      f.write(@player2.to_yaml)
      f.write(@board.to_yaml)
      f.write(@current_turn.to_yaml)
    end
  end

  def load_game
    File.open('save_data.yaml', 'r') do |f|
      array = YAML.load_stream(f)
      @player1 = array[0]
      @player2 = array[1]
      @board = array[2]
      @current_turn = array[3]
    end
  end

  def end_turn
    @current_turn == @player1 ? @player2 : @player1
  end

  def make_move
    player = @player1.color == @current_turn ? @player1 : @player2
    puts "#{player.name}'s turn, pick a piece to move:"
    selected_piece, starting_pos = @current_turn.select_piece(gets.chomp, @board)
    moves = return_valid(selected_piece, starting_pos)
    puts 'Valid movements are: '
    moves.each do |move|
      x, y = move
      board.selection_color(board.return_piece(move), x, y)
      board.print_board
    end
    selected_move = valid_move(selected_piece)
    @board.reset_background
    @board.move_piece(starting_pos, selected_move)
    @board.promotion
  end

  def valid_move(piece)
    puts 'Pick a place to move'
    input = gets.chomp
    input = input.split(',').map(&:to_i)
    return input if piece.valid_movements.include?(input)

    puts 'Invalid move, please try again'
    valid_move(piece)
  end

  def return_valid(piece, position)
    piece.return_valid(@board, position)
  end
end