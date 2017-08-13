require 'byebug'
require 'colorize'
require_relative 'cursor'
require_relative 'board'


class Display

  attr_reader :cursor

  def initialize(board, player_color)
    @board = board
    @player_color = player_color
    @cursor = Cursor.new([0, 0], @board)
  end

  def render
    system 'clear'
    @board.grid.each_with_index do |row, ridx|
      print '|'
      row.each_with_index do |piece, cidx|
        if @cursor.cursor_pos == [ridx, cidx]
          print piece.to_s.colorize(:background => :red)
        else
          print piece.to_s
        end
        print'|'
      end
      print "\n"
    end
    puts "Make a move #{@player_color} player."
    puts 'Use arrows to move the cursor and select with space or enter.'
    nil
  end

end
