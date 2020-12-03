class Space
  attr_reader :x, :y, :n
  attr_accessor :adjacent, :visited, :coordinates

  def initialize x, y
    @x = x
    @y = y
    @adjacent = []
    @visited = false
    @coordinates = [x, y]
  end
end

class Board
  attr_accessor :spaces, :adjacency_list
  
  def initialize
    @spaces = self.build_board
    @adjacency_list = self.set_knight_adjacencies
  end

  def build_board
    board = []
    8.times do |i|
      row = []
      8.times do |j|
        row << Space.new(i, j)
      end
      board << row
    end
    board
  end

  def find_knight_adjacencies start_space
    x = start_space.x
    y = start_space.y
    adj_spaces =  [[x + 2, y + 1], [x + 2, y - 1], [x - 2, y - 1], 
                   [x - 2, y + 1], [x + 1, y + 2], [x - 1, y + 2], 
                   [x - 1, y - 2], [x + 1, y - 2]] 
                   
    adj_spaces = adj_spaces.filter do |space|
      x = space[0]
      y = space[1]
      if x < 7 && x >= 0
        if y < 7 && y >= 0
           space
        end
      end
    end
    adj_spaces.sort.each {|e| start_space.adjacent << e}
  end

  def set_knight_adjacencies
    list = []
    self.spaces.each do |row|
      row.each do |space|
        self.find_knight_adjacencies space
        list << space.adjacent
      end
    end
    list
  end

  def print
    8.times do |i|
      row = []
      8.times do |j|
        row << self.spaces[i][j].coordinates
      end
      p row
    end
  end
end

class Knight

end
