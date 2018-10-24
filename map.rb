require_relative 'city'
# Map class is is using city object to a create an array of cities
# and connect them other cities
class Map
  # define a constant variables. NUM_CITIES = the total number of
  # cities in the map and pass that constant to the array @cities
  #
  NUM_CITIES = 7

  # Initialize map with array @cities contains objects of class
  # city and save them as the following
  # @cities[0] = Nevada City
  # @cities[1] = Angels Camp
  # @cities[2] = Sutter Creek
  # @cities[3] = Virginia City
  # @cities[4] = Coloma
  # @cities[5] = midas
  # @cities[6] = El Dorado Canyon
  #
  def initialize()
    @cities = Array.new()
    @cities[0]  = City.new('Nevada City', 0)
    @cities[1]  = City.new('Angels Camp', 1)
    @cities[2]  = City.new('Sutter Creek', 2)
    @cities[3]  = City.new('Virginia City', 3)
    @cities[4]  = City.new('Coloma', 4)
    @cities[5]  = City.new('Midas', 5)
    @cities[6]  = City.new('El Dorado Canyon', 6)
    connect_cities @cities
  end

  # @return [cities]
  attr_reader :cities

  def connect_cities(cities)
    # Connect the cities with each others according to D2 requirement.
    # ................................................................
    # Connect nevada with other neighboring cities
    connect_nevada_with_other cities
    # Connect Angels Camp with Nevada, Sutter Creek and Virginia City.
    connect_angels_with_other cities
    # Connect Sutter Creek with Coloma and Angels Camp.
    connect_sutter_with_other cities
    # Connect Coloma with Virginia City and Sutter Creek.
    connect_coloma_with_other cities
    # Connect Virginia City with Angels Camp, Coloma, Midas
    # and El Dorado Canyon.
    connect_virginia_with_other cities
    # Connect Midas with Virginia City and El Dorado Canyon.
    connect_midas_with_other cities
    # Connect El Dorado Canyon with Midas and Virginia City.
    connect_eldorado_with_other cities
  end

  # print all cities by passing the array of cities which contain the references
  # of all cities classes
  def print_map
    puts 'Location           | Max Silver    | Max Gold'
    puts '----------------------------------------------'
    @cities.length.times do |i|
      @cities[i].to_s
      puts
    end
  end

  # connect Nevada with Angels Camp
  def connect_nevada_with_other(cities)
    cities[0].connect cities[1]
  end

  # Connect Angels Camp with Nevada, Sutter Creek and Virginia City.
  def connect_angels_with_other(cities)
    cities[1].connect cities[0]
    cities[1].connect cities[2]
    cities[1].connect cities[3]
  end

  # Connect Sutter Creek with Coloma and Angels Camp.
  def connect_sutter_with_other(cities)
    cities[2].connect cities[1]
    cities[2].connect cities[4]
  end

  # Connect Virginia City with Angels Camp, Coloma, Midas and El Dorado Canyon.
  def connect_virginia_with_other(cities)
    cities[3].connect cities[1]
    cities[3].connect cities[4]
    cities[3].connect cities[5]
    cities[3].connect cities[6]
  end

  # Connect Coloma with Virginia City and Sutter Creek.
  def connect_coloma_with_other(cities)
    cities[4].connect cities[3]
    cities[4].connect cities[2]
  end

  # Connect Midas with Virginia City and El Dorado Canyon.
  def connect_midas_with_other(cities)
    cities[5].connect cities[3]
    cities[5].connect cities[6]
  end

  # Connect El Dorado Canyon with Midas and Virginia City.
  def connect_eldorado_with_other(cities)
    cities[6].connect cities[5]
    cities[6].connect cities[3]
  end
end
