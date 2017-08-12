class Move

  attr_reader :start_pos, :end_pos

  def initialize(start_pos, end_pos)
    @start_pos = start_pos
    @end_pos = end_pos
  end
end
