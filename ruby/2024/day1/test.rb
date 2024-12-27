require 'test/unit'
require_relative 'main'

class MainTest < Test::Unit::TestCase
  def test_iterate_wordfind_part1
    main = Main.new('test.txt')
    assert_equal(main.get_answer_1, 11)
  end

  def test_iterate_wordfind_part2
    main = Main.new('test_part2.txt')
    assert_equal(main.get_answer_2, 31)
  end

end