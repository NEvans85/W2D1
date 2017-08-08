require_relative 'piece'

class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(8) { Array.new(8) { NullPiece.new } }
    populate_board
  end

  def move_piece(start_pos, end_pos)
    raise NoMoveException if self[start_pos].is_a?(NullPiece)
    raise NoMoveException unless self[start_pos].valid_move?
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.new
  end

  def populate_board
    [0, 1, 6, 7].each { |r_idx| @grid[r_idx].map! { Piece.new } }
  end

  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end
end
