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
#
#
class Prospector
  # @return [max_pros]
  attr_reader :pros_id

  # the prospector has leave the city if it's true
  #
  attr_reader :has_to_leave
  def initialize(num, seed)
    @pros_id = num
    @id = 1
    @has_to_leave = false
    # create a map so the prospector can access to the cities
    map = Map. new seed

    # Total silver and total gold is to trace the total amount of metals
    # that prospector can earn

    @total_silver = 0
    @total_gold = 0
    start map.cities[2], @pros_id
  end

  # start method will put the prospector with his id in the first city the
  # prospector should visit which it  Sutter Creek
  def start(city, pros_id)
    print "Prospector #{pros_id} starting in #{city}."
  end

  def search_for_gold_or_silver(city, max_gold, max_silver)
    # checking if there is no gold or silver in the city
    # if no gold or silver found then the prospector has
    # to leave. return has_to_leave as true

    # case 1 when there is no gold and silver
    if max_gold.zero? && max_silver.zero?
      print "	Found no precious metals in #{city}."
      has_to_leave = true
      return has_to_leave
    end

    # case 2: checking if there is gold, but no silver
    #
    if !max_gold.zero? && max_silver.zero?
      # print if it singular
      #
      print "Found 1 ounce of gold in #{city}." if max_gold == 1
      # print if it plural
      #
      print "Found #{max_gold} ounces of gold in #{city}."
    end

    # case 3: if there is silver, but no gold
    #
    if !max_silver.zero? && max_gold.zero?
      # print if it singular
      print "Found 1 ounce of silver in #{city}." if max_silver == 1
    else
      # print if it plural
      print "Found #{max_silver} ounces of silver in #{city}."
    end
    #
    # case 4: if there gold and silver
  end
end
