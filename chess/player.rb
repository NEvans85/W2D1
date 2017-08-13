require_relative 'move'
require_relative 'display'

class Player
  attr_reader :color, :name
  def initialize(black_or_white, board, name = 'Human_Player')
    @color = black_or_white
    @board = board
    @name = name
    @display = Display.new(@board, @color)
  end

  def move
    @display.render
    start_pos = select_position
    end_pos = select_position
    Move.new(start_pos, end_pos, @board)
  end

  def select_position
    selection = nil
    while selection.nil?
      @display.render
      selection = @display.cursor.get_input
    end
    selection
  end

  def opp
    @color == :white ? :black : :white
  end
end
