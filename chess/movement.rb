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
    moves.uniq
  end

  def slide_moves(pos_increment)
    moves = []
    working_pos = @position.dup
    loop do
      working_pos.map!.with_index { |el, idx| el + pos_increment[idx] }
      if @board[working_pos].is_a?(NullPiece)
        moves << working_pos
      elsif @board[working_pos].color != self.color
        moves << working_pos
        break
      else
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
    slide_moves([-1, 0]) + slide_moves([-1, 0])
  end

  # def remove_invalid_moves(moves_arr)
  #   moves_arr.select do |pos|
  #     pos.all? { |el| (0..7).cover?(el) } &&
  #     @board[pos].color != self.color
  #   end
  # end

end

module SteppingPiece

  def moves
    moves = []
    steps.each do |pos_diff|
      working_pos = @position.dup
      working_pos.map!.with_index { |el, idx| el + pos_diff[idx] }
      if @board[working_pos].is_a?(NullPiece) ||
         @board[working_pos].color != self.color
        moves << working_pos
      end
    end
    moves
  end
end
