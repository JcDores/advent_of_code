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
      if @rules.key?(upd)
        previous_instructions = update[0..(index)]
        previous_instructions.each do |prev_instruc|
          return false if @rules[instruction].include?(prev_instruc)
        end
      end
    end
    true
  end

  def get_middle_instruction(update)
    middle_instruction = (update.size / 2.0).floor
    update[middle_instruction].to_i
  end

  def process_updates
    good_updates = @updates.filter do |upd|
      is_update_in_good_order(upd)
    end

    @answer = good_updates.map{ |upd| get_middle_instruction(upd) }.sum
  end

  def get_answer_1
    process_rules
    process_updates
    @answer
  end

  def get_answer_2
    process_rules
    @answer
  end
end

puts "The sum of middle of good updates is #{Main.new('rules.txt', 'updates.txt').get_answer_1}"