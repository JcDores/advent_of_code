require 'test/unit'
require_relative 'main'

class MainTest < Test::Unit::TestCase
  def test_reports_size
    main = Main.new('test.txt')
    assert_equal(main.reports.size, 7)
  end

  def test_process_reports_output_array_of_arrays
    main = Main.new('test.txt')
    assert_true(main.process_reports.all?{ |x| x.is_a?(Array) }, true)
  end

  def test_iterate_reports
    main = Main.new('test.txt')
    assert_equal(main.iterate_reports, 5)
  end
end