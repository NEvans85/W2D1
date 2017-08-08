require_relative 'piece'

class Board
  attr_reader :grid
  def initialize
    @grid = Array.new(8) { Array.new(8) { NullPiece.instance } }
    populate_std_board
  end

  def move_piece(start_pos, end_pos)
    raise NoMoveException if self[start_pos].is_a?(NullPiece)
    raise NoMoveException unless self[start_pos].valid_move?
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.instance
    self.position = end_pos
  end

  def populate_std_board
    [[0, 0], [0, 7]].each { |pos| self[pos] = Rook.new(:black, self, pos) }
    [[0, 1], [0, 6]].each { |pos| self[pos] = Knight.new(:black, self, pos) }
    [[0, 2], [0, 5]].each { |pos| self[pos] = Bishop.new(:black, self, pos) }
    self[[0, 3]] = King.new(:black, self, [0, 3])
    self[[0, 4]] = Queen.new(:black, self, [0, 4])
    @grid[1].map!.with_index { |_el, idx| Pawn.new(:black, self, [1, idx]) }
    [[7, 0], [7, 7]].each { |pos| self[pos] = Rook.new(:white, self, pos) }
    [[7, 1], [7, 6]].each { |pos| self[pos] = Knight.new(:white, self, pos) }
    [[7, 2], [7, 5]].each { |pos| self[pos] = Bishop.new(:white, self, pos) }
    self[[7, 4]] = King.new(:white, self, [0, 3])
    self[[7, 3]] = Queen.new(:white, self, [0, 4])
    @grid[6].map!.with_index { |_el, idx| Pawn.new(:white, self, [1, idx]) }
  end

  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end
end
