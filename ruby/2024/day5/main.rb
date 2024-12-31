class Main
  attr_accessor :rules, :rules_file, :updates_file, :updates, :answer
  def initialize(rules_file_name, updates_file_name)
    @rules_file = File.open(rules_file_name, 'r')
    @updates_file = File.open(updates_file_name, 'r')
    @rules = {}
    @updates = @updates_file.read.split("\n").map{ |upd| upd.split(',')}
    @answer = 0
  end

  def process_rules
    @rules_file.read.split("\n").each do |rule|
      trigger, effect = rule.split("|")
      if @rules.key?(trigger)
        @rules[trigger] << effect
      else
        @rules[trigger] = [effect]
      end
    end
    @rules
  end

  def is_update_in_good_order(update)
    update.each_with_index do |instruction, index|
      if @rules.key?(instruction)
        previous_instructions = update[0..(index)]
        previous_instructions.each do |prev_instruc|
          return { failed_index: index, success: false } if @rules[instruction].include?(prev_instruc)
        end
      end
    end
    { success: true }
  end

  def get_middle_instruction(update)
    middle_instruction = (update.size / 2.0).floor
    update[middle_instruction].to_i
  end

  def process_good_updates
    good_updates = @updates.filter do |upd|
      is_update_in_good_order(upd)[:success]
    end

    @answer = good_updates.map{ |upd| get_middle_instruction(upd) }.sum
  end

  def fix_bad_updates(upd)
    return upd if is_update_in_good_order(upd)[:success]

    failed_index = is_update_in_good_order(upd)[:failed_index]
    rules = @rules[upd[failed_index]]
    previous_instructions = upd.slice(0..failed_index)
    problems = rules & previous_instructions

    prob_index = problems.map { |prob| upd.index(prob) }.max  

    before_problem = prob_index == 0 ? [] : upd.slice(0..prob_index - 1)  
    problem = upd.slice(prob_index..prob_index)
    after_problem = upd.slice(prob_index + 1, upd.size) 

    upd = before_problem + after_problem.slice(0, 1) + problem + after_problem.slice(1, after_problem.size)  
    fix_bad_updates(upd)
  rescue SystemStackError
    raise
  end

  def process_bad_updates
    bad_updates = @updates.filter do |upd|
      !is_update_in_good_order(upd)[:success]
    end

    fixed_updates = bad_updates.map do |upd| 
      fix_bad_updates(upd)
    end

    @answer = fixed_updates.map{ |upd| get_middle_instruction(upd) }.sum
  end


  def get_answer_1
    process_rules
    process_good_updates
    @answer
  end

  def get_answer_2
    process_rules
    process_bad_updates
    @answer
  end
end

puts "The sum of middle in good updates is #{Main.new('rules.txt', 'updates.txt').get_answer_1}"
puts "The sum of middle in bad updates is #{Main.new('rules.txt', 'updates.txt').get_answer_2}"