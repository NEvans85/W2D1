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
    system 'clear'
    @board.grid.each_with_index do |row, ridx|
      print '|'
      row.each_with_index do |piece, cidx|
        if @cursor.cursor_pos == [ridx, cidx]
          print piece.to_s.colorize(:color => :white, :background => :red)
        else
          print piece.to_s
        end
        print'|'
      end
      print "\n"
    end
    nil
  end

  def select_position
    selection = nil
    while selection.nil?
      render
      selection = @cursor.get_input
    end
    selection
  end
end
