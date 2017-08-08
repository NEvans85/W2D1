class Piece

  def initialize(black_or_white, board)
    @color = black_or_white
    @board = board
  end

  def valid_move?(pos)
    self.moves.include?(pos)
  end

  def to_s; end

  def moves; end
end

class NullPiece < Piece
  include Singleton

  def to_s
    '_'
  end

  def valid_move?; end
    # TODO: write valid move logic by piece

  def moves; end

end

class Knight < Piece

  def to_s
    @color == :white ? code = 'U+2658' : code = 'U+265E'
    code.encode('utf-8')
  end

  def moves; end

end

class Bishop < Piece

  def to_s
    @color == :white ? code = 'U+2657' : code = 'U+265D'
    code.encode('utf-8')
  end

  def moves; end

end

class Rook < Piece

  def to_s
    @color == :white ? code = 'U+2656' : code = 'U+265C'
    code.encode('utf-8')
  end

end

class Queen < Piece

  def to_s
    @color == :white ? code = 'U+2655' : code = 'U+265B'
    code.encode('utf-8')
  end

end

class King < Piece

  def to_s
    @color == :white ? code = 'U+2654' : code = 'U+265A'
    code.encode('utf-8')
  end

end

class Pawn < Piece

  def to_s
    @color == :white ? code = 'U+2659' : code = 'U+265F'
    code.encode('utf-8')
  end

  def moves; end

end

module SlidingPiece

  def moves
  end

  def move_dirs
  end
end

module SteppingPiece
end
