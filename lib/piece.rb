# frozen_string_literal: true

class Piece
  attr_accessor :color, :valid_movements
  attr_reader :symbol

  def initialize(color)
    @color = color
    @valid_movements = []
    @starting_position = true
  end

  def same_color?(position, board)
    board = board.board
    x, y = position
    return unless board[x][y].is_a?(Piece)

    board[x][y].color == @color
  end

  def valid_moves(board, position)
    row, col = position
    movement(row, col, board)
  end

  def return_valid(board, position)
    board.save_board_state
    row, col = position
    moves = movement(row, col, board)
    @valid_movements = remove_invalid(position, board, moves)

    @valid_movements
  end

  def remove_invalid(original_pos, board, moves)
    invalid = []
    moves.each do |move|
      board.load_board_state
      board.move_piece(original_pos, move)
      king, king_position = board.find_king(color)

      invalid << move if king.check_threats(king_position, board)
    end
    board.load_board_state
    moves - invalid
  end

  def find_edge(row, col, direction, board, moves = [])
    x, y = direction
    row += x
    col += y
    return moves if row.negative? || col.negative? || row > 7 || col > 7
    return moves if same_color?([row, col], board)

    moves << [row, col]
    return moves if board.board[row][col].is_a?(Piece)

    find_edge(row, col, direction, board, moves) unless board.board[row][col].is_a?(Piece)
  end

  def scan_for_threats(row, col, direction, board, moves = [])
    x, y = direction
    row += x
    col += y
    return moves if row.negative? || col.negative? || row > 7 || col > 7

    moves << [row, col]

    return moves if board.board[row][col].is_a?(Piece)

    scan_for_threats(row, col, direction, board, moves) unless board.board[row][col].is_a?(Piece)
  end
end
