require 'byebug'
require 'colorize'
require_relative 'cursor'
require_relative 'board'


class Display
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], @board)
  end

  def render
    @board.grid.each_with_index do |row, ridx|
      row.each_with_index do |piece, cidx|
        if @cursor.cursor_pos == [ridx,cidx]
          print piece.to_s.colorize(:background=> :red)
        else
          print piece.to_s
      end
      end
      print "\n"
    end
  end

  def select_position
    while true
      render
      @cursor.get_input
      # debugger
    end
  end
end
