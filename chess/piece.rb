require 'singleton'
require_relative 'movement'

class Piece

  attr_reader :color

  def initialize(black_or_white, board, pos)
    @color = black_or_white
    @board = board
    @position = pos
  end

  def valid_move?(pos)
    self.moves.include?(pos)
  end

  def to_s; end

  def moves; end
end

class NullPiece < Piece
  include Singleton

  def initialize; end

  def to_s
    '_'
  end

  def valid_move?; end

  def moves; end

end

class Bishop < Piece
  include SlidingPiece

  def to_s
    @color == :white ? "\u2657" : "\u265D"
  end

  def move_dirs
    :diagonal
  end

end

class Rook < Piece

  include SlidingPiece

  def to_s
    @color == :white ? "\u2656" : "\u265C"
  end

  def move_dirs
    :horiz_vert
  end

end

class Queen < Piece

  include SlidingPiece

  def to_s
    @color == :white ? "\u2655" : "\u265B"
  end

  def move_dirs
    :both
  end

end

class Knight < Piece

  include SteppingPiece

  def to_s
    @color == :white ? "\u2658" : "\u265E"
  end

  def steps
    [2, -2].product([1, -1]) + [1, -1].product([2, -2])
  end

end

class King < Piece

  include SteppingPiece

  def to_s
    @color == :white ? "\u2654" : "\u265A"
  end

  def steps
    [-1, 0, 1].product([-1, 0, 1]) - [[0, 0]]
  end

end

class Pawn < Piece

  def to_s
    @color == :white ? "\u2659" : "\u265F"
  end

  def moves; end

end
