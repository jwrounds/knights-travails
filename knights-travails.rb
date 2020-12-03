class Space
  attr_reader :x, :y
  attr_accessor :adjacent, :visited, :coordinates, :d, :path

  def initialize x, y
    @x = x
    @y = y
    @d = 0
    @path = []
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
      if x <= 7 && x >= 0
        if y <= 7 && y >= 0
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
      end
    end
  end
end

class Knight

  def shortest_path start, stop, board = Board.new,

    start_space = board.spaces[start[0]][start[1]]
    stop_space = board.spaces[stop[0]][stop[1]]

    queue = [] 
    start_space.visited = true
    queue << start_space
  
    while queue.length > 0 
      current = queue.shift
      current.path << current.coordinates
      if current == stop_space
        str = "You made it in #{current.d} moves! Your path:"
        current.path.each {|space| str += "\n#{space}"}
        return puts str
      end
      current.adjacent.each do |adj|
        space = board.spaces[adj[0]][adj[1]]

        unless space.visited
          space.visited = true
          space.d = current.d + 1
          current.path.each {|s| space.path << s}
          queue.push space
        end
      end
    end
  end
end

board = Board.new
knight = Knight.new

knight.shortest_path([0,0], [7,7], board)