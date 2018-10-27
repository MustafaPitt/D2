# City Class: for each city it has a specific id as following beside max gold max silver as given by requirements
#
#   City Name             ID     Max Silver    Max gold
#
#   Nevada City           0         0       |    5
#   Angels Camp           1         0       |    4
#   Sutter Creek          2         0       |    2
#   Virginia City         3         3       |    3
#   Coloma                4         0       |    3
#   Midas                 5         5       |    0
#   El Dorado Canyon      6        10       |    0
#
#
# Note: the max silver and max gold values will pass through City class constructor in Map class
#
#
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

  def initialize(name, id, max_s, max_g)
    @name = name
    @id = id
    # each instance of city has an array of connection cities, basically each
    # index of the array contains a reference to another city class that prospector can
    # travel to. For example, Sutter Creek city contain 2 connections,
    # connections[0] = the reference of Angles camp and connections[1] =
    # reference of Coloma class
    @connections = []
    # Set the max random number of gold or silver based on D 2 requirement
    @max_gold = max_g
    @max_sliver = max_s
  end

  # Add a references to connection array
  def connect(value)
    connections.push value
  end
end
