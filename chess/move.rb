require_relative 'board'
class Move

  attr_reader :start_pos, :end_pos

  def initialize(start_pos, end_pos, board)
    @start_pos = start_pos
    @end_pos = end_pos
    @board = board
  end

  def ==(other)
    @start_pos == other.start_pos && @end_pos == other.end_pos
  end

  def inspect
    "#{@board[@start_pos].class} @ #{start_pos} to #{end_pos}"
  end
end
