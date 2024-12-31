class Main
  attr_accessor :map, :file_name, :answer
  def initialize(file_name)
    @map = File.open(file_name, 'r').read.split("\n").map(&:chars)
    @current_position = find_guard
    @direction = 0
    @answer = 0
  end

  def find_guard
    @map.each_with_index do |line, y_pos|
      line.each_with_index do |char, x_pos|
        return {x: x_pos, y: y_pos} if char == '^' 
      end
    end
  end

  def print_map
    printted_map = @map.map do |line|
      line.join('')
    end
    puts printted_map
    puts "END  MAP"
  end

  def move_in_direction
    case @direction % 360
    when 0
      return go_up
    when 90
      return go_right
    when 180
      return go_down
    when 270
      return go_left
    end
    return false
  end

  def go_up
    @map[@current_position[:y]][@current_position[:x]] = 'X'
    new_y = @current_position[:y] - 1
    return false if new_y == -1 # Hit the top!

    if @map[new_y][@current_position[:x]] == '#'
      @direction += 90
      return true
    end
    
    @map[new_y][@current_position[:x]] = '^'
    @current_position[:y] = new_y
    true
  end

  def go_down
    @map[@current_position[:y]][@current_position[:x]] = 'X'
    new_y = @current_position[:y] + 1

    return false if new_y >= @map.size  # Hit the bottom!

    if @map[new_y][@current_position[:x]] == '#'
      @direction += 90
      return true
    end
    
    @map[new_y][@current_position[:x]] = 'v'
    @current_position[:y] = new_y
    true
  end

  def go_left
    @map[@current_position[:y]][@current_position[:x]] = 'X'
    new_x = @current_position[:x] - 1
    return false if new_x == -1 # Out of Bounds

    if @map[@current_position[:y]][new_x] == '#'
      @direction += 90
      return true
    end
    
    @map[@current_position[:y]][new_x] = '<'
    @current_position[:x] = new_x
    true
  end

  def go_right
    @map[@current_position[:y]][@current_position[:x]] = 'X'
    new_x = @current_position[:x] + 1
    return false if new_x >= @map[@current_position[:y]].size # Out of Bounds
    
    if @map[@current_position[:y]][new_x] == '#'
      @direction += 90
      return true
    end

    @map[@current_position[:y]][new_x] = '>'
    @current_position[:x] = new_x
    true
  end

  def move_guard
    return unless move_in_direction

    move_in_direction
    move_guard
  end

  def count_x_in_map
    @answer = @map.map do |line|
      line.count('X')
    end.sum
  end

  def get_answer_1
    move_guard
    print_map # Last Update on Map
    count_x_in_map
    puts @direction / 360.0
    @answer
  end

  def get_answer_2
    @answer
  end
end

puts "The steps that the guard took is #{Main.new('test.txt').get_answer_1}"
# puts "The sum of middle in bad updates is #{Main.new('rules.txt').get_answer_2}"