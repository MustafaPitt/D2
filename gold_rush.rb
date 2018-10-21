require_relative 'map.rb'
require_relative 'prospector'
require_relative 'rules'
# Gold Rush
# 1632 CS PITT --D2 -- Prof. Bill Laboon
# Author: Mustafa Al Azzawi

# start main her

rule = Rules.new
rule.check_args ARGV[0], ARGV[1]

seed = ARGV[0].to_i
numb_of_pros = ARGV[1].to_i

prng = Random.new seed
prospectors = []

numb_of_pros.times do |id|
  prospectors[id] = Prospector.new id, prng

  while prospectors[id].visited_num < 5
    puts prospectors[id].get_start_msg prospectors[id].current_city, prospectors[id].pros_id
    while prospectors[id].has_to_leave == false
      prospectors[id].search_msg_first_3_ir prospectors[id].current_city, prospectors[id].
    end
    prospectors[id].visited_num +=1
  end
end

