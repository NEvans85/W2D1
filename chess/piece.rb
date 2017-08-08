require 'singleton'

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

  def to_s
    @color == :white ? "\u2658" : "\u265E"
  end

end

class King < Piece

  def to_s
    @color == :white ? "\u2654" : "\u265A"
  end

end

class Pawn < Piece

  def to_s
    @color == :white ? "\u2659" : "\u265F"
  end

  def moves; end

end

module SlidingPiece

  def moves
    moves = []
    case move_dirs
    when :diagonal
      moves += diagonals
    when :horiz_vert
      moves += row + col
    when :both
      moves += diagonals + row + col
    end
    remove_invalid_moves(moves.uniq)
  end

  def diagonals
    diagonals = []
    8.times do |i|
      diagonals << [@position[0] + i, @position[1] + i]
      diagonals << [@position[0] + i, @position[1] - i]
      diagonals << [@position[0] - i, @position[1] + i]
      diagonals << [@position[0] - i, @position[1] - i]
    end
    diagonals
  end

  def row
    row = []
    8.times { |i| row << [@position[0], i] }
    row
  end

  def col
    col = []
    8.times { |i| col << [i, @position[1]] }
    col
  end

  def remove_invalid_moves(moves_arr)
    moves_arr.select do |pos|
      pos.all? { |el| (0..7).cover?(el) } &&
      @board[pos].color != self.color
    end
  end

end

module SteppingPiece
end
