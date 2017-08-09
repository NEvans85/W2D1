class Player
  attr_reader :color, :name
  def initialize(black_or_white, name = 'Player')
    @color = black_or_white
    @name = name
  end
end
