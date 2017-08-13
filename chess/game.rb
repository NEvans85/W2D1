require_relative 'board'
require_relative 'display'
require_relative 'player'

class Chess

  attr_reader :player1, :player2

  def initialize(p1_name, p2_name)
    @board = Board.new
    @board.standard_setup
    @player1 = Player.new(:white, @board, p1_name)
    @player2 = Player.new(:black, @board, p2_name)
    @curr_player = @player1
  end

  def play
    take_turn until game_over?
  end

  def take_turn
    begin
      @board.move_piece(@curr_player.move, @curr_player.color)
    rescue
      puts 'Invalid Move.'
      retry
    end
    switch_players!
  end

  def switch_players!
    @curr_player == @player1 ? @curr_player = @player2 : @curr_player = @player1
  end

  def game_over?
    if @board.loser?(@curr_player.color)
      puts "#{@curr_player.name} is in checkmate."
      return true
    end
    false
  end
end

Chess.new("White", "Black").play
