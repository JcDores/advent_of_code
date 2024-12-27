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
  attr_accessor :reports, :file_name, :safe_reports
  def initialize(file_name, target_word)
    @file = File.open(file_name, 'r')
    @xmas_wordfind = @file.read.split("\n").map(&:chars)
    @target_word = target_word
    @hits = 0
  end


  def find_word_horizontal(x_index, y_index, word = '')
    word += @xmas_wordfind[y_index][x_index]
    return 1 if word == @target_word || word == @target_word.reverse
    
    return 0 if word.size >= @target_word.size
    
    if (x_index + 1) >= @xmas_wordfind[y_index].size
      return word == @target_word || word == @target_word.reverse ? 1 : 0
    end
    
    find_word_horizontal(x_index + 1, y_index, word)
  end

  def find_word_vertical(x_index, y_index, word = '')
    word += @xmas_wordfind[y_index][x_index]
    return 1 if word == @target_word || word == @target_word.reverse
    
    return 0 if word.size >= @target_word.size

    if (y_index + 1) >= @xmas_wordfind.size
      return word == @target_word || word == @target_word.reverse ? 1 : 0
    end

    find_word_vertical(x_index, y_index + 1, word)
  end

  def find_word_diagonal(x_index, y_index, word = '')
    word += @xmas_wordfind[y_index][x_index]
    return 1 if word == @target_word || word == @target_word.reverse
    
    return 0 if word.size >= @target_word.size

    if (y_index + 1) >= @xmas_wordfind.size || (x_index + 1) >= @xmas_wordfind[y_index].size
      return word == @target_word || word == @target_word.reverse ? 1 : 0
    end

    find_word_diagonal(x_index + 1, y_index + 1, word)
  end

  def find_word_reverse_diagonal(x_index, y_index, word = '')
    word += @xmas_wordfind[y_index][x_index]
    return 1 if word == @target_word || word == @target_word.reverse
    
    return 0 if word.size >= @target_word.size

    if (x_index - 1) < 0 || (y_index + 1) >= @xmas_wordfind.size
      return word == @target_word || word == @target_word.reverse ? 1 : 0
    end

    find_word_reverse_diagonal(x_index - 1, y_index + 1, word)
  end

  def find_all_directions(x, y)
    find_word_horizontal(x, y) + find_word_vertical(x, y) + find_word_diagonal(x, y) + find_word_reverse_diagonal(x, y)
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
    @xmas_wordfind.each_with_index do |wordrow, y|
      wordrow.each_with_index do |wordcol, x|
        if wordcol == @target_word[0] && wordrow[x + 2] == @target_word[-1]
          @hits += find_all_directions(x, y)
        end
      end
    end
  end
end

puts "Finding in XMAS in wordfind ... #{Main.new('input.txt', 'XMAS').iterate_wordfind_part1} XMAS found."