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
      @checkmate = false
      game_loop
    end
  end

  def save_game
    File.open('save_data.yaml', 'w') do |f|

      f.write(@player1.to_yaml)
      f.write(@player2.to_yaml)
      f.write(@board.to_yaml)
      f.write(@current_turn.to_yaml)
      f.write(@checkmate.to_yaml)
    end
  end

  def load_game
    File.open('save_data.yaml', 'r') do |f|
      array = YAML.load_stream(f)
      @player1 = array[0]
      @player2 = array[1]
      @board = array[2]
      @current_turn = array[3]
      @checkmate = array[4]
    end
  end

  def end_turn
    @current_turn = @current_turn == @player1 ? @player2 : @player1
  end

  def game_loop
    until @checkmate
      @board.print_board
      #player = @player1.color == @current_turn ? @player1 : @player2
      puts "#{@current_turn.name}'s turn, pick a piece to move:"
      selected_piece, starting_pos = @current_turn.select_piece(board)
      moves = return_valid(selected_piece, starting_pos)
      moves.each do |move|
        x, y = move
        board.selection_color(board.return_piece(move), x, y)
        board.print_board
      end
      if moves.empty?
        puts 'No moves for this piece, pick another piece'
        sleep(2)
        next
      end
      selected_move = valid_move(selected_piece)
      @board.reset_background
      @board.move_piece(starting_pos, selected_move)
      @board.promotion
      @board.print_board
      end_turn
    end
  end

  def valid_move(piece)
    puts 'Pick a place to move'
    input = @current_turn.parse_movement(gets.chomp)
    return input if piece.valid_movements.include?(input)

    puts 'Invalid move, please try again'
    valid_move(piece)
  end

  def return_valid(piece, position)
    piece.return_valid(@board, position)
  end
end