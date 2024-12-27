# --- Day 4: Ceres Search ---
# "Looks like the Chief's not here. Next!" One of The Historians pulls out a device and pushes the only button on it. After a brief flash, you recognize the interior of the Ceres monitoring station!

# As the search for the Chief continues, a small Elf who lives on the station tugs on your shirt; she'd like to know if you could help her with her word search (your puzzle input). She only has to find one word: XMAS.

# This word search allows words to be horizontal, vertical, diagonal, written backwards, or even overlapping other words. It's a little unusual, though, as you don't merely need to find one instance of XMAS - you need to find all of them. Here are a few ways XMAS might appear, where irrelevant characters have been replaced with .:

# ..X...
# .SAMX.
# .A..A.
# XMAS.S
# .X....


# Take a look at the little Elf's word search. How many times does XMAS appear?
# 

class Main
  attr_accessor :xmas_wordfind, :file_name, :hits
  def initialize(file_name, target_word)
    @file = File.open(file_name, 'r')
    @xmas_wordfind = @file.read.split("\n").map(&:chars)
    @target_word = target_word
    @hits = 0
  end


  def find_word_horizontal(x_index, y_index, target_word, word = '')
    word += @xmas_wordfind[y_index][x_index]
    return 1 if word == target_word
    
    return 0 if word.size >= target_word.size
    
    if (x_index + 1) >= @xmas_wordfind[y_index].size
      return word == target_word ? 1 : 0
    end
    
    find_word_horizontal(x_index + 1, y_index, target_word, word)
  end

  def find_word_vertical(x_index, y_index, target_word, word = '')
    word += @xmas_wordfind[y_index][x_index]
    return 1 if word == target_word
    
    return 0 if word.size >= target_word.size

    if (y_index + 1) >= @xmas_wordfind.size
      return word == target_word ? 1 : 0
    end

    find_word_vertical(x_index, y_index + 1, target_word, word)
  end

  def find_word_diagonal(x_index, y_index, target_word, word = '')
    word += @xmas_wordfind[y_index][x_index]
    return 1 if word == target_word

    return 0 if word.size >= target_word.size

    if (y_index + 1) >= @xmas_wordfind.size || (x_index + 1) >= @xmas_wordfind[y_index].size
      return word == target_word ? 1 : 0
    end

    find_word_diagonal(x_index + 1, y_index + 1, target_word, word)
  end

  def find_word_reverse_diagonal(x_index, y_index, target_word, word = '')
    word += @xmas_wordfind[y_index][x_index]
    return 1 if word == target_word

    return 0 if word.size >= target_word.size

    if (x_index - 1) < 0 || (y_index + 1) >= @xmas_wordfind.size
      return word == @target_word ? 1 : 0
    end

    find_word_reverse_diagonal(x_index - 1, y_index + 1, target_word, word)
  end

  def find_all_directions(x, y)
    find_word_horizontal(x, y, @target_word) + find_word_vertical(x, y, @target_word) + 
    find_word_diagonal(x, y, @target_word) + find_word_reverse_diagonal(x, y, @target_word) +
    find_word_horizontal(x, y, @target_word.reverse) + find_word_vertical(x, y, @target_word.reverse) + 
    find_word_diagonal(x, y, @target_word.reverse) + find_word_reverse_diagonal(x, y, @target_word.reverse)
  end

  def find_x_shaped(x1,y1, x2, y2)
    found_shaped = 0
    found_shaped += 1 if find_word_diagonal(x1, y1, @target_word) == 1 && find_word_reverse_diagonal(x2, y2, @target_word) == 1
    found_shaped += 1 if find_word_diagonal(x1, y1, @target_word.reverse) == 1 && find_word_reverse_diagonal(x2, y2, @target_word) == 1
    found_shaped += 1 if find_word_diagonal(x1, y1, @target_word) == 1 && find_word_reverse_diagonal(x2, y2, @target_word.reverse) == 1
    found_shaped += 1 if find_word_diagonal(x1, y1, @target_word.reverse) == 1 && find_word_reverse_diagonal(x2, y2, @target_word.reverse) == 1

    found_shaped
  end

  def iterate_wordfind_part1
    @xmas_wordfind.each_with_index do |wordrow, y|
      wordrow.each_with_index do |wordcol, x|
        if wordcol == @target_word[0] || wordcol == @target_word[-1]
          @hits += find_all_directions(x, y)
        end
      end
    end
    @hits
  end

  def iterate_wordfind_part2
    chars_to_start = @target_word[0], @target_word[-1]
    @xmas_wordfind.each_with_index do |wordrow, y|
      wordrow.each_with_index do |wordcol, x|
        if chars_to_start.include?(wordcol) && chars_to_start.include?(wordrow[x + 2]) && (x + 2) < wordrow.size
          @hits += find_x_shaped(x, y, x + 2, y)
        end
      end
    end
    @hits
  end
end

puts "Finding in XMAS in wordfind ... #{Main.new('input.txt', 'XMAS').iterate_wordfind_part1} found."
puts "Finding in MAS in X shaped wordfind ... #{Main.new('input.txt', 'MAS').iterate_wordfind_part2} MAS found."