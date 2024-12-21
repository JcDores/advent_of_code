# This example data contains six reports each containing five levels.

# The engineers are trying to figure out which reports are safe. The Red-Nosed reactor safety systems can only tolerate levels that are either gradually increasing or gradually decreasing. So, a report only counts as safe if both of the following are true:

# The levels are either all increasing or all decreasing.
# Any two adjacent levels differ by at least one and at most three.
# In the example above, the reports can be found safe or unsafe by checking those rules:

# 7 6 4 2 1: Safe because the levels are all decreasing by 1 or 2.
# 1 2 7 8 9: Unsafe because 2 7 is an increase of 5.
# 9 7 6 2 1: Unsafe because 6 2 is a decrease of 4.
# 1 3 2 4 5: Unsafe because 1 3 is increasing but 3 2 is decreasing.
# 8 6 4 4 1: Unsafe because 4 4 is neither an increase or a decrease.
# 1 3 6 7 9: Safe because the levels are all increasing by 1, 2, or 3.
# So, in this example, 2 reports are safe.

# Analyze the unusual data from the engineers. How many reports are safe?

class Main
  attr_accessor :reports, :file_name, :safe_reports
  def initialize(file_name)
    @file = File.open(file_name, 'r')
    @reports = @file.read.split("\n")
    @safe_reports = 0
  end


  def iterate_reports
    reports = process_reports
    safe_reports = 0
    reports.each do |report|
      parsed_report = report.map(&:to_i)
      
      result = is_a_safe_report(parsed_report)
      is_a_safe_report = result[:success]
      if result[:success] == false
        tolerance_result = tolerance_attempt(parsed_report, result[:level_to_remove])
        is_a_safe_report = tolerance_result.nil? ? false : true
      end

      if tolerance_result
        puts "Original: #{parsed_report} Removed Index #{tolerance_result[:index]} List Result #{tolerance_result[:list]} is #{is_a_safe_report ? 'Safe' : 'Unsafe'}"
      end

      safe_reports += 1 if is_a_safe_report
    end

    safe_reports
  end

  def tolerance_attempt(parsed_report, failed_index)
    tolerances = (0..failed_index).map do |index_to_remove|
      list_without_index = parsed_report.clone
      list_without_index.delete_at(index_to_remove)
      { list: list_without_index, index: failed_index }.merge(is_a_safe_report(list_without_index))
    end

    tolerances.find{ |x| x[:success] == true }
  end

  def is_a_safe_report(parsed_report)
    parsed_report.each_with_index do |level, index|
      return { success: false, level_to_remove: index + 1 }  if is_a_safe_level(parsed_report, level, index) == false
    end

    { success: true }
  end

  def is_a_safe_level(report, level, index)
    next_level = report[index + 1]
    if next_level.nil?
      return true
    end

    if difference_between_levels(level, next_level) >= 4 || difference_between_levels(level, next_level).zero? 
      return false
    end

    return nominated_operator(level, next_level) if index.zero?

    continued_sequence = eval("#{level} #{@nominated_operator} #{next_level}")
    if continued_sequence == false
      return false
    end
  end

  def difference_between_levels(level, next_level)
    (level - next_level).abs
  end
  
  def nominated_operator(level, next_level)
    @nominated_operator = (level - next_level) > 0 ? '>' : '<' 
  end

  def process_reports
    @reports.map do |report|
      report.split(' ')
    end
  end
end

puts "The answer is #{Main.new('input.txt').iterate_reports}"