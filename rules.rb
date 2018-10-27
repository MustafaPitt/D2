require_relative 'prospector'

# This class is to set specific rules for the program. For example. The prospector has to leave the city if the gold
# less than 1 and silver less than 2 after third visited city.
class Rules
  # check if args are valid
  def check_args?(seed, number_of_pros)
    if ARGV.count != 2
      print invalid_msg
      exit(1)
    end
    unless valid_input? seed, number_of_pros
      print invalid_msg
      exit 1
    end
    true
  end

  def valid_input?(seed, number_of_pros)
    # return true only if the seed is negative or positive and the number of prospectors only positive
    return true if (pos_neg_int? seed) && (pos_int? number_of_pros)

    false
  end

  # return true if the input only positive integer
  def pos_int?(input)
    return true if input.match?(/^\d+$/)

    false
  end

  # @return true if the input only negative or positive integer
  def pos_neg_int?(input)
    return true if input.match?(/^-?\d+$/)

    false
  end

  def invalid_msg
    puts 'Usage:'
    puts 'ruby gold_rush.rb *seed* *num_prospectors*'
    puts '*seed* should be an integer'
    puts '*num_prospectors* should be a non-negative integer'
  end

  def first_3_cities(id, prng, pross)
    # get the id of Sutter Creek to make the prospector start with
    # for each prospector visit three cities
    until pross[id].visited_num >= 3
      # set the start city for each prospector as Sutter Creek
      #
      # search in the current city until you find no precious metals
      until pross[id].has_to_leave
        # Counting days in the current city
        pross[id].increment_count_days
        # get random value for gold
        curr_gold = pross[id].get_ran_gold pross[id].current_city.id, prng, pross[id].current_city.max_gold
        # get random value for silver
        cur_silver = pross[id].get_ran_silver pross[id].current_city.id, prng, pross[id].current_city.max_sliver
        # print message for current metals found
        puts pross[id].get_msg_search_first_3_ir pross[id].current_city.name, curr_gold, cur_silver
        # collect the metals
        # add the metals to the instance class @total silver and gold #
        pross[id].collect_metals curr_gold, cur_silver
      end
      # find another destination to go
      # temporary variable to save the current city so we can print the moving message
      prev_city = pross[id].current_city
      # get random number up to the max of array length of connections. for example
      # instance class of Sutter Creek has array connections that has references to 2 cities
      # Angel Camp and Coloma. When we pass the array length of connections to get_another_id
      # will return a number up length -1, so sutter creek will return either 0 or 1
      #  and pass this index to connections to get the city id

      i = pross[id].get_another_id prng, pross[id].current_city.connections.length
      pross[id].current_city = prev_city.connections[i]

      # print move message
      puts pross[id].move_msg prev_city.name, pross[id].current_city.name, pross[id].t_gold, pross[id].t_silver

      # increment the visited city
      pross[id].increment_visit

      # set has to leave to false so he can search again
      pross[id].has_to_leave = false
    end
  end

  def final_2_cities(id, prng, pross)
    # get the id of the current city the prospector at after finished the first 3 cities
    # for each prospector visit three cities
    until pross[id].visited_num >= 5
      # set the start city for each prospector as Sutter Creek
      # search in the current city until you find no precious metals
      until pross[id].has_to_leave
        # count days in each city
        pross[id].increment_count_days
        # get random value for gold
        curr_gold = pross[id].get_ran_gold pross[id].current_city.id, prng, pross[id].current_city.max_gold
        # get random value for silver
        cur_silver = pross[id].get_ran_silver pross[id].current_city.id, prng, pross[id].current_city.max_sliver
        # print message for current metals found
        puts pross[id].search_for_gold_or_silver_final_2 pross[id].current_city.name, curr_gold, cur_silver
        # collect the metals
        # add the metals to the instance class variables @total silver and gold
        pross[id].collect_metals curr_gold, cur_silver
      end
      # find another destination to go
      # temporary variable to save the current city so we can print the moving message
      prev_city = pross[id].current_city

      # get random number up to the max of array length of connections. for example
      # instance class of Sutter Creek has array connections the has references to 2 cities
      # Angel Camp and Coloma. When we pass the array length of connections to get_another_id
      # will return a number up length -1, so sutter creek will return 0 or 1
      # and these and pass this index to connections to get the city id
      i = pross[id].get_another_id prng, pross[id].current_city.connections.length
      pross[id].current_city = prev_city.connections[i]
      # increment the visited city
      pross[id].increment_visit
      # print move message
      unless pross[id].visited_num == 5
        puts pross[id].move_msg prev_city.name, pross[id].current_city.name, pross[id].t_gold, pross[id].t_silver
      end
      # set has to leave to false so the prospector can search again
      pross[id].has_to_leave = false
    end
  end
end
