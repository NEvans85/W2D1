require 'singleton'
require 'byebug'
require_relative 'movement'

class Piece

  attr_reader :color
  attr_accessor :board, :position

  def initialize(black_or_white, board, pos)
    @color = black_or_white
    @board = board
    @position = pos
  end

  def valid_move?(move)
    moves.include?(move) && (@board[move.end_pos].is_a?(NullPiece) ||
                             @board[move.end_pos].color != @color)
  end

  def inspect
    "#{@color} #{self.class} @ #{@position}"
  end

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

  include SteppingPiece

  def to_s
    @color == :white ? "\u2659" : "\u265F"
  end

  def steps
    @color == :white ? white_steps : black_steps
  end

  def black_steps
    steps = []
    steps << [1, 0] if @board[@position.sum([1, 0])].is_a?(NullPiece)
    steps << [2, 0] if @position[0] == 1 &&
                       @board[@position.sum([2, 0])].is_a?(NullPiece)
    steps << [1, 1] if @position.sum([1, 1]).all? { |i| (0..7).cover?(i) } &&
                       @board[@position.sum([1, 1])].color == :white
    steps << [1, -1] if @position.sum([1, -1]).all? { |i| (0..7).cover?(i) } &&
                        @board[@position.sum([1, -1])].color == :white
    steps
  end

  def white_steps
    steps = []
    steps << [-1, 0] if @board[@position.sum([-1, 0])].is_a?(NullPiece)
    steps << [-2, 0] if @position[0] == 6 &&
                        @board[@position.sum([-2, 0])].is_a?(NullPiece)
    steps << [-1, 1] if @position.sum([-1, 1]).all? { |i| (0..7).cover?(i) } &&
                        @board[@position.sum([-1, 1])].color == :black
    steps << [-1, -1] if @position.sum([-1, -1]).all? { |i| (0..7).cover?(i) } &&
                         @board[@position.sum([-1, -1])].color == :black
    steps
  end

end

class Array
  def sum(other_array)
    map.with_index { |el, idx| el + other_array[idx] }
  end
end
