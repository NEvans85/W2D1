require_relative 'board'
require_relative 'display'

class Chess

  attr_reader :player1, :player2

  def initialize(p1_name, p2_name)
    @board = Board.new
    @display = Display.new(@board)
    @player1 = Player.new(:white, p1_name)
    @player2 = Player.new(:black, p2_name)
  end

  def play
    take_turn until game_over?
  end
end
