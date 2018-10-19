# City Class: for each city it has a specific id as following
#
#   City Name             ID
#
#   Nevada City           0
#   Angels Camp           1
#   Sutter Creek          2
#   Virginia City         3
#   Coloma                4
#   Midas                 5
#   El Dorado Canyon      6
#
#  I'm using city ID instead of city name. If you have a trouble
#  understand the id, please check the table above
class City
  # @return [city name]
  attr_reader :name

  # @return [city id]
  attr_reader :id

  # @return [connections]
  attr_reader :connections

  # @return [@max_gold]
  attr_reader :max_gold

  # @return [@max_silver]
  attr_reader :max_sliver

  def initialize(name, id, seed)
    # call srand with the passed seed
    @name = name
    @id = id
    # each instance of city has an array of connection cities, basically each
    # index contains a reference to another city class that prospector can
    # travel to. For example, Sutter Creek city contain 2 connections,
    # connections[0] = the reference of Angles camp and connections[1] =
    # reference of Coloma
    @connections = []
    # Set the max random number of gold or silver based on D 2 requirement
    @max_gold = gen_ran_gold seed, id
    @max_sliver = gen_ran_silver seed, id
  end

  def to_s
    print "#{name}   |\t#{@max_sliver}\t   | \t#{@max_gold}"
    puts
  end

  # Add a references to connection array
  def connect(value)
    connections.push value
  end

  # return a random number up to the max of gold in city according to
  # D2 requirement
  # @return [Max Gold]
  # @param [city id] id
  # @param [seed] seed

  def gen_ran_gold(seed, id)

    prng = Random.new seed

    # if city id = 0 = Nevada City
    # return max number between 0 and 5
    return prng.rand(5 + 1) if id.zero?

    # if city id = 1 = Angels Camp
    return prng.rand(4 + 1) if id == 1

    # if city id = 2 = Sutter Creek
    return prng.rand(2 + 1) if id == 2

    # if city id = 3 = Virginia City or
    # city id = 4 = Coloma

    return prng.rand (3 + 1) if id.between?(3, 4)
    # if city id = 5 = Midas or
    # if city id = 6 = El Dorado Canyon
    return 0 if id.between?(5, 6)

    print 'Error index ID not found in the System \n'
  end


  # return a random number up to the max of silver in city according to
  # D2 requirement
  # @return [Max Gold]
  # @param [Object] id
  def gen_ran_silver(seed, id)
    prng = Random.new(seed)

    # if city id = 0 = Nevada City
    # if city id = 1 = Angels Camp
    # if city id = 2 = Sutter Creek
    # # if city id = 4 = Coloma
    return 0 if id.between?(0, 2) || id == 4
    # if city id = 3 = Virginia City
    return prng.rand(3 + 1) if id == 3
    # if city id = 5 = Midas
    return prng.rand(5 + 1) if id == 5
    # if city id = 6 = El Dorado Canyon
    return prng.rand(10 + 1) if id == 6

    print 'Error index ID not found in the System \n'
  end
end
