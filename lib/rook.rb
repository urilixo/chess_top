class Rook < Piece
  def initialize(color, position)
    super
    @symbol = @color == 'white' ? ' ♜ ' : ' ♖ '
  end

  def return_valid(board)
    row, col = @position
    valid_moves = ortogonal(row, col, board)
    @valid_movements = valid_moves
  end

  def ortogonal(row, col, board, valid_moves = [])
    if row.positive?
      (row - 1).downto(0).each do |cell|
        if board[cell][col].is_a?(Piece)
          valid_moves << [cell, col] if board[cell][col].color != @color
          break
        end

        valid_moves << [cell, col]
      end
    end
    if row < 7
      (row + 1).upto(7).each do |cell|
        if board[cell][col].is_a?(Piece)
          valid_moves << [cell, col] if board[cell][col].color != @color
          break
        end

        valid_moves << [cell, col]
      end
    end
    if col.positive?
      (col - 1).downto(0).each do |cell|
        if board[row][cell].is_a?(Piece)
          valid_moves << [row, cell] if board[row][cell].color != @color
          break
        end

        valid_moves << [row, cell]
      end
    end
    if col < 7
      (col + 1).upto(7).each do |cell|
        if board[row][cell].is_a?(Piece)
          valid_moves << [row, cell] if board[row][cell].color != @color
          break
        end

        valid_moves << [row, cell]
      end
    end
    valid_moves
  end
end