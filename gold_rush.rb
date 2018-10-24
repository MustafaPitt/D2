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

pross = []

map = Map.new


def first_3_cities(id, map, prng, pross)
  # get the id of Sutter Creek to make the prospector start with
  c_indx = 2
  # for each prospector visit three cities
  until pross[id].visited_num >= 3
    # set the start city for each prospector as Sutter Creek
    #
    pross[id].current_city = map.cities[c_indx].name
    city_id = map.cities[c_indx].id

    #
    # print start message
    puts pross[id].get_start_msg pross[id].current_city, pross[id].pros_id
    # search in the current city until you find no precious metals
    until pross[id].has_to_leave == true
      # Counting days in the current city
      pross[id].increment_count_days
      # get random value for gold
      curr_gold = pross[id].get_ran_gold city_id, prng, map.cities[c_indx].max_gold
      # get random value for silver
      cur_silver = pross[id].get_ran_silver city_id, prng, map.cities[c_indx].max_gold
      # print message for current metals found
      puts pross[id].search_msg_first_3_ir pross[id].current_city, curr_gold, cur_silver
      # collect the metals
      # add the metals to the instance class @total silver and gold #
      pross[id].collect_metals curr_gold, cur_silver, pross[id].has_to_leave
      #

    end
    # find another destination to go
    # temporary variable to save the current city so we can print the moving message
    temp_inx = c_indx
    # get random number up to the max of array length of connections. for example
    # instance class of Sutter Creek has array connections the has references to 2 cities
    # Angel Camp and Coloma. When we pass the array length of connections to get_another_id
    # will return a number up length -1, so sutter creek will return 0 or 1
    # and these and pass this index to connections to get the city id
    i = pross[id].get_another_id prng, map.cities[c_indx].connections.length
    c_indx = map.cities[temp_inx].connections[i].id

    # Get the current city id so the prospector can use it to start search in final 2 cities
    pross[id].city_id = c_indx

    # print move message

    puts pross[id].move_msg map.cities[temp_inx].name, map.cities[c_indx].name, pross[id].t_gold, pross[id].t_silver

    # incrument the visited city
    pross[id].increment_visit

    # set has to leave to false so he can search again
    pross[id].has_to_leave = false
  end
end

def final_2_cities(id, map, prng, pross)
  # get the id of the current city the prospector at after finished the first 3 cities
  c_indx = pross[id].city_id
  # for each prospector visit three cities
  until pross[id].visited_num >= 5
    # set the start city for each prospector as Sutter Creek
    pross[id].current_city = map.cities[c_indx].name
    city_id = map.cities[c_indx].id
    # print start message
    puts pross[id].get_start_msg pross[id].current_city, pross[id].pros_id
    # search in the current city until you find no precious metals
    until pross[id].has_to_leave == true
      #
      # count days in each city
      pross[id].increment_count_days
      # get random value for gold
      curr_gold = pross[id].get_ran_gold city_id, prng, map.cities[c_indx].max_gold
      # get random value for silver
      cur_silver = pross[id].get_ran_silver city_id, prng, map.cities[c_indx].max_gold
      # print message for current metals found
      puts pross[id].search_for_gold_or_silver_final_2 pross[id].current_city, curr_gold, cur_silver
      # collect the metals
      # add the metals to the instance class variables @total silver and gold
      pross[id].collect_metals curr_gold, cur_silver, pross[id].has_to_leave

      #
    end
    # find another destination to go
    # temporary variable to save the current city so we can print the moving message
    temp_inx = c_indx
    # get random number up to the max of array length of connections. for example
    # instance class of Sutter Creek has array connections the has references to 2 cities
    # Angel Camp and Coloma. When we pass the array length of connections to get_another_id
    # will return a number up length -1, so sutter creek will return 0 or 1
    # and these and pass this index to connections to get the city id
    i = pross[id].get_another_id prng, map.cities[c_indx].connections.length
    c_indx = map.cities[temp_inx].connections[i].id


    # print move message
    unless pross[id].has_to_leave
    puts pross[id].move_msg map.cities[temp_inx].name, map.cities[c_indx].name, pross[id].t_gold, pross[id].t_silver
    end
    # incrument the visited city
    #
    pross[id].increment_visit

    # set has to leave to false so he can search again
    pross[id].has_to_leave = false
  end
end

numb_of_pros.times do |id|

  pross[id] = Prospector.new id, prng

  # pass a prospectors starting with  id = 0 to the search in first 3 cities
  first_3_cities(id, map, prng, pross)
  # Past the same prospector to search in final 2 cities
  final_2_cities(id, map, prng, pross)
  # print the prosppector final message
  #
  # convet total gold and silver that earned by prospector to cash
  cash = pross[id].convert_metals_to_cash pross[id].t_gold, pross[id].t_silver

  # print back home message
  # days, pros_id, t_gold, t_silver, cash
  pross[id].back_home_msg pross[id].count_days,id, pross[id].t_gold, pross[id].t_silver, cash
end




