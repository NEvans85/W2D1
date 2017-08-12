require_relative 'board'
require_relative 'display'

class Chess

  attr_reader :player1, :player2

  def initialize(p1_name, p2_name)
    @board = Board.new
    @display = Display.new(@board)
    @player1 = Player.new(:white, p1_name)
    @player2 = Player.new(:black, p2_name)
    @curr_player = [@player1, @player2].sample
  end

  def play
    take_turn until game_over?
  end

  def take_turn
    @board.move_piece(@curr_player.move)
    rescue
      puts "Invalid Move."
      retry
    end
    switch_players!
  end

  def switch_players!
    @curr_player == @player1 ? @curr_player = @player2 : @curr_player = @player1
  end
end
