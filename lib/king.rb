class King < Piece
  attr_accessor :first_move
  
  def initialize(color)
    super
    @symbol = @color == 'white' ? ' ♔ ' : ' ♚ '
    @first_move = true
    @diagonals = []
    @orthogonals = []
    @knight_moves = []
  end

  def valid_castle(board, row, col)
    movements = []
    # King side castle
    if board[row][col + 3].is_a?(Rook) && board[row][col + 3].first_move
      movements.append([0, 2]) unless board[row][col + 1].is_a?(Piece) || board[row][col + 2].is_a?(Piece)
    end
    # Queen side castle
    if board[row][col - 4].is_a?(Rook) && board[row][col - 4].first_move
      unless board[row][col - 1].is_a?(Piece) || board[row][col - 2].is_a?(Piece) || board[row][col - 3].is_a?(Piece)
        movements.append([0, -2])
      end
    end
    movements
  end

  def movement(row, col, board)
    moves = []
    directions = [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, -1], [-1, 1], [1, 1], [1, -1]]
    directions += valid_castle(board.board, row, col) if @first_move
    directions.each do |cell|
      x, y = cell
      next if (row + x).negative? || (col + y).negative? || (row + x) > 7 || col + y > 7

      new_position = [row + x, col + y]
      moves += [new_position] unless same_color?(new_position, board)
    end
    moves
  end

  def check_threats(king_position, board)
    row, col = king_position
    update_threats(row, col, board)
    # Look for pieces that could threaten king around him, of opposite color
    @diagonals.each do |diagonal|
      x, y = diagonal
      if (board.board[x][y].is_a?(Queen) || board.board[x][y].is_a?(Bishop)) && board.board[x][y].color != color
        return true
      end
    end
    @orthogonals.each do |orthogonal|
      x, y = orthogonal
      if (board.board[x][y].is_a?(Queen) || board.board[x][y].is_a?(Rook)) && board.board[x][y].color != color
        return true
      end
    end
    @knight_moves.each do |l_move|
      x, y = l_move
      return true if board.board[x][y].is_a?(Knight) && board.board[x][y].color != color
    end
    false
  end

  def update_threats(row, col, board)
    diagonals = [[-1, -1], [-1, 1], [1, 1], [1, -1]]
    orthogonals = [[0, -1], [1, 0], [-1, 0], [0, 1]]
    knight_moves = [[-1, -2], [-2, -1], [-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2]]
    @orthogonals = threat_directions(row, col, orthogonals, board)
    @diagonals = threat_directions(row, col, diagonals, board)
    @knight_moves = knight_threat(row, col, knight_moves)
  end

  def knight_threat(row, col, directions)
    threats = []
    directions.each do |vector|
      x, y = vector
      next if (row + x).negative? || (col + y).negative? || (row + x) > 7 || col + y > 7

      new_position = [row + x, col + y]
      threats += [new_position]
    end
    threats
  end

  def threat_directions(row, col, directions, board)
    threats = []
    directions.each { |vector| threats += scan_for_threats(row, col, vector, board)}
    threats
  end
end
