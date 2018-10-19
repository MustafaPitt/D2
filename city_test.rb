require 'minitest/autorun'
require_relative 'city'
class CityTest < Minitest::Test
  # test random gold method and make sure the values are withing requirements range
  # We're checking the method through the global variable @max_gold
  def test_rand_gold
    20.times do |seed|
      # test Nevada
      nevada = City.new('Nevada City', 0, seed)
      assert_operator 5, :<=, nevada.max_gold
      assert_operator 0, :>=, nevada.max_gold

      # angel city has max gold between 0 to 4
      # generate seed from 0 to 20 and test the max
      # gold will stay between 0 and 4
      angels = City.new('Angels Camp', 1, seed)
      assert_operator 4, :<=, angels.max_gold
      assert_operator 0, :>=, angels.max_gold

      # Coloma gold max gold should be between 0 and 3
      coloma = City.new('Coloma', 4, seed)
      assert_operator 3, :<=, coloma.max_gold
      assert_operator 0, :>=, coloma.max_gold

      # Sulter Creek max gold should be between 0 and 2
      sultter = City.new('Sutter Creek', 2, seed)
      assert_operator 2, :<=, sultter.max_gold
      assert_operator 0, :>=, sultter.max_gold

      # Virginia City should be betweeb 0 and 3
      virginia = City.new('Virginia City', 3, seed)
      assert_operator 2, :<=, virginia.max_gold
      assert_operator 0, :>=, virginia.max_gold
      #  Midas and El Dorado Canyon will return 0

      eldrado = City.new('El Dorado Canyon', 6, seed)
      assert_equal 0, eldrado.max_gold
      midas = City.new('Midas', 5, seed)
      assert_equal 0, midas.max_gold
    end
  end

  # test random silver method and make sure the values are withing requirements
  # range. We're checking the method through the global variable @max_silver
  def test_rand_silver
    # Sutter Creek, Coloma, Angels Camp, Nevada City and Nevada City
    # has max_silver = 0

    30.times do |seed|
      sultter = City.new('Sutter Creek', 2, seed)
      assert_equal 0, sultter.max_sliver

      coloma = City.new('Coloma', 4, seed)
      assert_equal 0, coloma.max_sliver

      angels = City.new('Angels Camp', 1, seed)
      assert_equal 0, angels.max_sliver

      nevada = City.new('Nevada City', 0, seed)
      assert_equal 0, nevada.max_sliver

      # Virginia City, max silver is 3
      virginia = City.new('Virginia City', 3, seed)
      assert_operator 3, :<=, virginia.max_sliver
      assert_operator 0, :>=, virginia.max_sliver

      # Midas City, Max silver is 5
      midas = City.new('Midas', 5, seed)
      assert_operator 5, :<=, midas.max_sliver
      assert_operator 0, :>=, midas.max_sliver

      # El Dorado, max silver is 10
      eldrado = City.new('El Dorado Canyon', 6, seed)
      assert_operator 10, :<=, eldrado.max_sliver
      assert_operator 0, :>=, eldrado.max_sliver
    end
  end
end
