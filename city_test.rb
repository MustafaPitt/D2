require 'minitest/autorun'
require_relative 'city'

# Testing City.rb class
class CityTest < Minitest::Test
  # test random gold method and make sure the values are withing requirements range
  # We're checking the method through the global variable @max_gold

  # test connect: every time we add a city, it will add to @connections array
  #

  def test_connect
    # create 2 cities
    nevada = City.new('Nevada City', 0, 0, 5)
    angel = City.new('Angels Camp', 1, 0, 4)
    # connect nevada with angel
    nevada.connect angel
    # testing if nevada connected with Angel Camp by testing global array @connections
    assert_equal nevada.connections[0], angel
  end
end
