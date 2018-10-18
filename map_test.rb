require 'minitest/autorun'
require_relative 'city'
require_relative 'map'
class MapTest < Minitest::Test
  # check connections map. Each city has a valid road to its neighbouring
  # cities matching by matching the map in requirements.

  # checking if Nevada City is connected Angels Camp city
  # the cities array indexes as following
  # @cities[0] = Nevada City
  # @cities[1] = Angels Camp
  # @cities[2] = Sutter Creek
  # @cities[3] = Virginia City
  # @cities[4] = Coloma
  # @cities[5] = midas
  # @cities[6] = El Dorado Canyon

  # test Nevada City on index cities[0] which it has an array of connections
  # has a connection at connections[0] index connected with Angels Camp
  def test_nevada_connections
    map = Map.new 15
    # checking connection by name
    assert_equal 'Angels Camp', map.cities[0].connections[0].name
    # checking connection by ID of Angel Camp
    assert_equal 1, map.cities[0].connections[0].id
  end

  # test Angel camp city in index @cities[1] has an array of connections
  # with Nevada, Sutter Creek and Virginia City.
  def test_angel_camp_connections
    map = Map.new 15
    # checking if Angel camp on index @cities[1]
    # is connected with......
    #
    # First: with Nevada, it should be on index 0 of array connections
    # checking Angel camp is connected with Nevada
    # checking by name
    assert_equal 'Nevada City', map.cities[1].connections[0].name
    #
    # checking by ID
    assert_equal 0, map.cities[1].connections[0].id
    #
    # Second:
    # Checking Angel camp is connected with Sutter Creek
    assert_equal 'Sutter Creek', map.cities[1].connections[1].name
    # checking by id
    assert_equal 2, map.cities[1].connections[1].id
    #
    # Third:
    # checking Angel camp is connected with Virgina City
    # checking by name
    assert_equal 'Virginia City', map.cities[1].connections[2].name
    # checking by id
    assert_equal 3, map.cities[1].connections[2].id
  end

end