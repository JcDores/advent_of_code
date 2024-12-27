require 'test/unit'
require_relative 'main'

class MainTest < Test::Unit::TestCase
  def test_iterate_wordfind_part1
    main = Main.new('test.txt', 'XMAS')
    assert_equal(main.iterate_wordfind_part1, 18)
  end

  def test_iterate_wordfind_part2
    main = Main.new('test_part2.txt', 'MAS')
    assert_equal(main.iterate_wordfind_part2, 9)
  end

end