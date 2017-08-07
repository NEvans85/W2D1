require_relative 'piece'

class Board
 attr_reader :grid
  def initialize
    @grid = Array.new(8) { Array.new(8) { NullPiece.new } }

  end

  def move_piece(start_pos, end_pos)
    raise NoPieceException if self[start_pos].is_a?(NullPiece)
    raise NoMoveException unless self[end_pos].is_a?(NullPiece)
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.new
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
