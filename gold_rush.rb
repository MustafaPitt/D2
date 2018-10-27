require_relative 'map.rb'
require_relative 'prospector'
require_relative 'rules'
# Gold Rush
# 1632 CS PITT --D2 -- Prof. Bill Laboon
# Author: Mustafa Al Azzawi
#=======================================
# init rules
rule = Rules.new
# check args if and only if seed = [Neg or Pos integer] and number of prospector is positive integer
rule.check_args? ARGV[0], ARGV[1]
seed = ARGV[0].to_i
numb_of_pros = ARGV[1].to_i
# set the pseudo number genrator to the given seeds
prng = Random.new seed
# create array of prospectors
prospectors = [numb_of_pros]
# init map
map = Map.new
numb_of_pros.times do |id|
  # make prospector id start with 1
  id += 1
  # create a new prospector and add the array of prospectors
  prospectors[id] = Prospector.new id, prng
  # set the current city for prospector to start to Sutter Creek
  # Please check the city ID for a reference
  prospectors[id].current_city = map.cities[2]
  # print prospector starting message
  puts prospectors[id].get_start_msg prospectors[id].current_city.name, id
  # pass a prospectors starting with  id# to the search in first 3 cities
  rule.first_3_cities(id, prng, prospectors)
  # Past the same prospector to search in final 2 cities
  rule.final_2_cities(id, prng, prospectors)
  # print the prospector final message
  #
  # convert total gold and silver that earned by prospector to cash
  cash = prospectors[id].convert_metals_to_cash prospectors[id].t_gold, prospectors[id].t_silver
  # print back home message
  prospectors[id].back_home_msg prospectors[id].count_days, id, prospectors[id].t_gold, prospectors[id].t_silver, cash
end
