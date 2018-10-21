require 'minitest/autorun'
require_relative 'city'
class CityTest < Minitest::Test
  # test random gold method and make sure the values are withing requirements range
  # We're checking the method through the global variable @max_gold
  #
  #
  def test_max_gold

    # test Nevada
    # Max gold should be 5
    nevada = City.new('Nevada City', 0)
    assert_equal 5, nevada.max_gold

    # angel city has max gold 4
    #
    angels = City.new('Angels Camp', 1)
    assert_equal 4, angels.max_gold
    #
    #
    # Coloma has max gold 3
    #
    coloma = City.new('Coloma', 4)
    assert_equal 3, coloma.max_gold

    # Sulter Creek has max gold 2
    sultter = City.new('Sutter Creek', 2)
    assert_equal 2, sultter.max_gold

    # Virginia City has max gold 3
    virginia = City.new('Virginia City', 3)
    assert_equal 3, virginia.max_gold

    #  Midas and El Dorado Canyon has max gold 0

    eldrado = City.new('El Dorado Canyon', 6)
    assert_equal 0, eldrado.max_gold
    midas = City.new('Midas', 5)
    assert_equal 0, midas.max_gold
  end

  # test max silver method and make sure the values are within D2 requirements
  # We're checking the method through the global variable @max_silver

  def test_max_silver
    # Sutter Creek, Coloma, Angels Camp, Nevada City and Nevada City
    # has max_silver = 0


    sultter = City.new('Sutter Creek', 2)
    assert_equal 0, sultter.max_sliver

    coloma = City.new('Coloma', 4)
    assert_equal 0, coloma.max_sliver

    angels = City.new('Angels Camp', 1)
    assert_equal 0, angels.max_sliver

    nevada = City.new('Nevada City', 0)
    assert_equal 0, nevada.max_sliver

    # Virginia City, max silver is 3
    virginia = City.new('Virginia City', 3)
    assert_equal 3, virginia.max_sliver

    # Midas City, Max silver is 5
    midas = City.new('Midas', 5)
    assert_equal 5, midas.max_sliver

    # El Dorado, max silver is 10
    eldrado = City.new('El Dorado Canyon', 6)
    assert_equal 10, eldrado.max_sliver
  end
end
