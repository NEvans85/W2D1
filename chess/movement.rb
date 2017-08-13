require_relative 'move'

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
    moves
  end

  private

  def slide_moves(pos_increment)
    moves = []
    working_pos = @position.dup
    loop do
      working_pos.map!.with_index { |el, idx| el + pos_increment[idx] }
      if working_pos.any? { |el| el < 0 || el > 7 } ||
         @board[working_pos].nil? ||
         @board[working_pos].color == color
        break
      elsif @board[working_pos].is_a?(NullPiece)
        moves << Move.new(@position, working_pos.dup, @board)
      elsif @board[working_pos].color != color
        moves << Move.new(@position, working_pos.dup, @board)
        break
      end
    end
    moves
  end

  def diagonals
    slide_moves([-1, -1]) + slide_moves([-1, 1]) +
    slide_moves([1, 1]) + slide_moves([1, -1])
  end

  def row
    slide_moves([0, -1]) + slide_moves([0, 1])
  end

  def col
    slide_moves([-1, 0]) + slide_moves([1, 0])
  end

end

module SteppingPiece

  def moves
    moves = []
    steps.each do |pos_diff|
      working_pos = @position.dup
      working_pos.map!.with_index { |el, idx| el + pos_diff[idx] }
      if working_pos.all? { |el| (0..7).cover?(el) } &&
         (@board[working_pos].is_a?(NullPiece) ||
          @board[working_pos].color != color)
        moves << Move.new(@position, working_pos.dup, @board)
      end
    end
    moves
  end
end
