class Board
  require 'colorize'
  require_relative 'piece'
  attr_reader :board

  def initialize(rows: 8, columns: 8)
    new_board(rows, columns)
  end

  def new_board(rows, columns)
    @board = Array.new(rows) { Array.new(columns) }
    @board.each_with_index do |row, i|
      row.each_with_index do |_cell, j|
        @board[i][j] = (i + j).even? ? '   '.on_white : '   '.on_black
      end
    end
  end

  def set_starting_pieces
    set_black_pieces('black', [1, 0])
    set_white_pieces('white', [6, 7])
  end

  def return_piece(position)
    row, col = position
    @board[row][col] if @board[row][col].is_a?(Piece)
  end

  def set_pieces(color, rows)
    pawn_row, special_row = rows
    @board[pawn_row].each_with_index { |_square, index| place_piece(Pawn.new(color, [pawn_row, index])) }
    # Rooks
    place_piece(Rook.new(color, [special_row, 0]))
    place_piece(Rook.new(color, [special_row, 7]))
    # Knights
    place_piece(Knight.new(color, [special_row, 1]))
    place_piece(Knight.new(color, [special_row, 6]))
    # Bishops
    place_piece(Bishop.new(color, [special_row, 2]))
    place_piece(Bishop.new(color, [special_row, 5]))
    # Queen
    place_piece(Queen.new(color, [special_row, 3]))
    # King
    place_piece(King.new(color, [special_row, 4]))
  end

  def place_piece(piece)
    x, y = piece.position
    @board[x][y] = piece
  end

  def move_piece(before, after)
    place_piece(after)
    y, x = before
    @board[x][y] = (x + y).even? ? '   '.on_white : '   '.on_black
  end

  def background_color(piece)
    x, y = piece.position
    (x + y).even? ? piece.symbol.black.on_white : piece.symbol.white.on_black
  end

  def print_board
    printed = []
    @board.each do |row|
      temp_row = []
      row.each do |cell|
        cell = cell.is_a?(Piece) ? background_color(cell) : cell
        temp_row << cell
      end
      printed << temp_row
    end
    printed.each { |row| puts row.join }
  end
end
