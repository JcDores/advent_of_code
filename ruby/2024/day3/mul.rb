# "Our computers are having issues, so I have no idea if we have any Chief Historians in stock! You're welcome to check the warehouse, though," says the mildly flustered shopkeeper at the North Pole Toboggan Rental Shop. The Historians head out to take a look.

# The shopkeeper turns to you. "Any chance you can see why our computers are having issues again?"

# The computer appears to be trying to run a program, but its memory (your puzzle input) is corrupted. All of the instructions have been jumbled up!

# It seems like the goal of the program is just to multiply some numbers. It does that with instructions like mul(X,Y), where X and Y are each 1-3 digit numbers. For instance, mul(44,46) multiplies 44 by 46 to get a result of 2024. Similarly, mul(123,4) would multiply 123 by 4.

# However, because the program's memory has been corrupted, there are also many invalid characters that should be ignored, even if they look like part of a mul instruction. Sequences like mul(4*, mul(6,9!, ?(12,34), or mul ( 2 , 4 ) do nothing.

# For example, consider the following section of corrupted memory:

# xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
# Only the four highlighted sections are real mul instructions. Adding up the result of each instruction produces 161 (2*4 + 5*5 + 11*8 + 8*5).

# Scan the corrupted memory for uncorrupted mul instructions. What do you get if you add up all of the results of the multiplications?

class Mul
  attr_accessor :corrupted_memory, :file_name

  UNCORRUPTED_BITS_REGEX = /don't\(\)|do\(\)|mul\(\d*,\d*\)/
  MUL_REGEX = /mul\(\d*,\d*\)/
  
  def initialize(file_name)
    @file = File.open(file_name, 'r')
    @corrupted_memory = @file.read
    @uncorrupted_bits = []
    @mul_count = 0
    @mul_enabled = true
  end

  def process_memory
    scan_memory
    @uncorrupted_bits.each do |bit|
      check_do_or_dont(bit)
      next unless @mul_enabled

      next unless bit.match?(MUL_REGEX)

      result = eval(bit) 
      @mul_count += result
    end

    @mul_count
  end

  def check_do_or_dont(bit)
    return @mul_enabled = true if bit === 'do()'
    
    return @mul_enabled = false if bit === "don't()"
  end

  def mul(num1, num2)
    num1 * num2
  end

  def scan_memory
    @uncorrupted_bits = @corrupted_memory.scan(UNCORRUPTED_BITS_REGEX)
    puts "FOUND #{@uncorrupted_bits.size} UNCORRUPTED BITS"
  end
end

puts "The answer is #{Mul.new('input.txt').process_memory}"