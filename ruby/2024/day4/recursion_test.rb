list = [
  [1, 2, 3],
  [2, 4, 6],
  [5, 6 ,7],
]

def recursive_sum_horizontal(list, x_index, y_index)
   return list[y_index][x_index] if (x_index + 1) >= list[y_index].size

   return list[y_index][x_index] + recursive_sum_horizontal(list, x_index + 1, y_index)
end

def recursive_sum_vertical(list, x_index, y_index)
  return list[y_index][x_index] if (y_index + 1) >= list.size

  return list[y_index][x_index] + recursive_sum_vertical(list, x_index, y_index + 1)
end

def recursive_sum_diagonal(list, x_index, y_index)
  return list[y_index][x_index] if (y_index + 1) >= list.size || (x_index + 1) >= list[y_index].size

  return list[y_index][x_index] + recursive_sum_diagonal(list, x_index + 1, y_index + 1)
end

def recursive_sum_reverse_diagonal(list, x_index, y_index)
  return list[y_index][x_index] if (y_index - 1) < 0 || (x_index + 1) >= list[y_index].size

  return list[y_index][x_index] + recursive_sum_reverse_diagonal(list, x_index + 1, y_index - 1)
end

def recursively_sum_all_directions(list, index)

end

#puts "FIRST ROW", recursive_sum_horizontal(list, 0, 0)
#puts "Second ROW", recursive_sum_horizontal(list, 0, 1)
#puts "Third ROW", recursive_sum_horizontal(list, 0, 2)
# puts "FIRST ROW Vertical", recursive_sum_vertical(list, 0, 0)
# puts "Second ROW Vertical", recursive_sum_vertical(list, 1, 0)
# puts "Third ROW Vertical", recursive_sum_vertical(list, 2, 0)
#puts "First row diagonal", recursive_sum_diagonal(list, 0, 0)
#puts "Second row diagonal", recursive_sum_diagonal(list, 1, 0)
#puts "Third row diagonal", recursive_sum_diagonal(list, 0, 1)
puts "Third ROW Diagonal Reverse", recursive_sum_reverse_diagonal(list, 0, 2)
puts "Second ROW Diagonal Reverse", recursive_sum_reverse_diagonal(list, 0, 1)
puts "Second Row Diagonal Reverse", recursive_sum_reverse_diagonal(list, 1, 2)

