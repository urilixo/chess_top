class Pawn < Piece
  def initialize(color)
    super
    @symbol = @color == 'white' ? ' ♙ ' : ' ♟︎ '
    @first_move = true
  end

  def movement(row, col, board)
    moves = []
    places = []
    @color == 'black' ? places << [1, 0] : places << [-1, 0]
    places << [2, 0] if @first_move && color == 'black'
    places << [-2, 0] if @first_move && color == 'white'
    places += can_attack(row, col, board)
    places.each do |cell|
      x, y = cell
      next if (row + x).negative? || (col + y).negative? || (row + x) > 7 || col + y > 7
      new_position = [row + x, col + y]
      moves += [new_position] unless board.board[row + x][col + y].is_a?(Piece)
      moves += [new_position] if board.board[row + x][col + y].is_a?(Piece) && y != 0
    end
    @first_move = false
    moves
  end

  def can_attack(row, col, board)
    attack_direction = []
    modifier = color == 'white' ? -1 : +1
    if board.board[row + modifier][col + 1].is_a?(Piece) && !same_color?([row + modifier, col + 1], board)
      attack_direction << [modifier, 1]
    elsif board.board[row + modifier][col - 1].is_a?(Piece) && !same_color?([row + modifier, col - 1], board)
      attack_direction << [modifier, -1]
    end
    attack_direction
  end

end