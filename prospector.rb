# In class prospective, we will keep using map and cities
# the prospective should visit theses randomly
#
#
#    City ID Codes
#    @cities[0] = Nevada City
#    @cities[1] = Angels Camp
#    @cities[2] = Sutter Creek
#    @cities[3] = Virginia City
#    @cities[4] = Coloma
#    @cities[5] = midas
#    @cities[6] = El Dorado Canyon
class Prospector
  # @return [prod_id]
  attr_reader :pros_id

  # the prospector has leave the city if it's true

  # @return [current_city] it's a reference to object city
  attr_accessor :current_city

  # use to count how many cities are visited
  # @return [visited_num]
  attr_reader :visited_num
  # @return [total gold]
  attr_reader :t_gold

  # @return [total silver]
  attr_reader :t_silver

  # use to count how many days that each prospector spends in a city
  attr_reader :count_days

  attr_accessor :has_to_leave

  def initialize(id, prng)
    @has_to_leave = false
    @pros_id = id

    # create a map so the prospector can access to the cities
    # Total silver and total gold is to trace the total amount of metals
    # that prospector can earn

    @t_silver = 0
    @t_gold = 0
    @prng = prng

    # is the current city that prospector in
    @current_city = nil

    # save and truck number of visited city
    @visited_num = 0
    # city id of sutter Creek is 2
    @count_days = 0
  end

  def increment_count_days
    @count_days += 1
  end

  def increment_visit
    @visited_num += 1
  end

  # start method will return the start message about which
  # city that prospector should start with. In our program it should
  # be 2 Sutter Creek
  #
  def get_start_msg(city, pros_id)
    "Prospector #{pros_id} starting in #{city}.\n"
  end

  # search_for_gold_or_silver_first_3_ir method should return an appropriate string message based on
  # the gold and silver parameters. It should handle properly the singular and plural cases
  # of ounce and ounces for gold and silver
  # Also, there is boolean [has to leave] it should set true
  # when there is no gold or silver ==> when  both are equal 0
  # this method for the first 3 irritation

  def get_msg_search_first_3_ir(city, gold, silver)
    #
    # case 1 when there is no gold and silver
    # the method will print Found no precious metals in #{city}."
    # and return has to leave as true
    #
    if gold.zero? && silver.zero?
      @has_to_leave = true
      return "Found no precious metals in #{city}.\n"
    end

    # case 2: checking if there is gold, but no silver
    # print the appropriated message singular or plural
    #
    return get_sing_plur_gold_msg city, gold if !gold.zero? && silver.zero?
    #
    # case 3: if there is silver, but no gold
    # print the appropriated message singular or plural
    #
    return get_sing_plur_silver_msg city, silver if gold.zero? && !silver.zero?
    #
    # case 4: if there gold and silver
    return get_sing_plur_silver_gold_msg city, gold, silver if !gold.zero? && !silver.zero?

    raise "Error in search for gold or silver\n"
  end

  #
  #
  # Requirement 7: During the final two locations a prospector searches, they shall leave a location if they find one
  # ounce or fewer of gold and two ounces or fewer of silver. If they find either two ounces or more of gold, or
  # three ounces or more of silver, they will remain
  #
  # # search_for_gold_or_silver_first_final_2  method should return an appropriate string message based on
  #  gold and silver parameters. It should handle properly the singular and plural cases
  # of ounce and ounces for gold and silver
  # Also, there is boolean [has to leave] it should set true
  # when there is ounce or fewer of gold and two ounces or fewer of silver
  # this method for the first 3 irritation.
  #
  def search_for_gold_or_silver_final_2(city, gold, silver)
    #
    # when gold <= 1 and silver <= 2
    # set has to leave as true
    @has_to_leave = true if gold <= 1 && silver <= 2
    # contains the the amount of metals found
    handle_and_get_final_2_msg city, gold, silver
  end

  # These 2 print methods below simply will print the appropriate message if
  # the sentence singular, it will print with ounce, else it will print ounces
  # for both gold silver found
  # @param [msg] max_gold
  def get_sing_plur_gold_msg(city, max_gold)
    return "Found 1 ounce of gold in #{city}.\n" if max_gold == 1

    # return this string if it plural

    "Found #{max_gold} ounces of gold in #{city}.\n"
  end

  def get_sing_plur_silver_msg(city, max_silver)
    # print if it singular
    return "Found 1 ounce of silver in #{city}.\n" if max_silver == 1

    # return this string  if it plural
    "Found #{max_silver} ounces of silver in #{city}.\n"
  end

  # # print when both gold and silver are > 0
  def get_sing_plur_silver_gold_msg(city, max_gold, max_silver)
    # print message for gold
    str1 = get_sing_plur_gold_msg city, max_gold
    # get message for silver
    str2 = get_sing_plur_silver_msg city, max_silver
    str1 + str2
  end

  # this method will print found gold or silver with ounces amount and print
  # the appropriate message. It's for the final 2 irritation. We'll use it when
  # the max gold <= 1 and Max_silver <= 2
  #
  def handle_and_get_final_2_msg(city, max_gold, max_silver)
    #
    # check if there no gold or silver
    #
    return "Found no precious metals in #{city}.\n" if max_gold.zero? && max_silver.zero?
    #
    #
    # check if there is only gold
    #
    return get_sing_plur_gold_msg city, max_gold if !max_gold.zero? && max_silver.zero?
    #
    # check if there is only silver
    #
    return get_sing_plur_silver_msg city, max_silver if max_gold.zero? && !max_silver.zero?

    #
    # if there is gold and silver
    #
    get_sing_plur_silver_gold_msg city, max_gold, max_silver if !max_gold.zero? && !max_silver.zero?
  end

  # passing the city id and prng to get random gold
  # up to the max_gold in city

  def get_ran_gold(id_city, prng, max_gold)
    # if city id = 0 = Nevada City
    # return max number between 0 and 5
    return prng.rand(max_gold + 1) if id_city.zero?

    # if city id = 1 = Angels Camp
    return prng.rand(max_gold + 1) if id_city == 1

    # if city id = 2 = Sutter Creek
    return prng.rand(max_gold + 1) if id_city == 2

    # if city id = 3 = Virginia City or
    # city id = 4 = Coloma

    return prng.rand(max_gold + 1) if id_city.between?(3, 4)
    # if city id = 5 = Midas or
    # if city id = 6 = El Dorado Canyon
    return 0 if id_city.between?(5, 6)

    print 'Error index ID not found in the System \n'
  end

  # passing the city id and prng to get random silver number
  # up to the max_silver in city
  #
  def get_ran_silver(id_city, prng, max_silver)
    # if city id = 0 = Nevada City
    # if city id = 1 = Angels Camp
    # if city id = 2 = Sutter Creek
    # # if city id = 4 = Coloma
    # return 0
    return 0 if id_city.between?(0, 2) || id_city == 4
    # if city id = 3 = Virginia City
    return prng.rand(max_silver + 1) if id_city == 3
    # if city id = 5 = Midas
    return prng.rand(max_silver + 1) if id_city == 5
    # if city id = 6 = El Dorado Canyon
    return prng.rand(max_silver + 1) if id_city == 6

    print 'Error index ID not found in the System \n'
  end

  # get another city id  randomly
  def get_another_id(prng, max_con)
    # max_con is max_con is equal to max array length of connections
    # each instance of class city has connections array and this array contains the
    # references to the other cities
    prng.rand(max_con)
  end

  def move_msg(cur_city, dest_city, g_earned, sil_earned)
    "Heading from #{cur_city} to #{dest_city}, holding #{g_earned} ounces of gold and #{sil_earned} ounces of silver.\n"
  end

  def collect_metals(gold, silver)
    @t_gold += gold
    @t_silver += silver
  end

  def back_home_msg(days, pros_id, t_gold, t_silver, cash)
    puts "After #{days} days, Prospector #{pros_id} returned to San Francisco with:"
    puts "#{t_gold} ounces of gold."
    puts "#{t_silver} ounces of silver."
    puts "Heading home with $#{cash}."
  end

  def convert_metals_to_cash(gold, silver)
    raise 'ERROR : non positive integer for gold or silver' unless gold >= 0 && silver >= 0

    cash = (gold * 20.67) + (silver * 1.31)
    cash.round(2)
  end
end
