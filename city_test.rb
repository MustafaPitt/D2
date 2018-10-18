require 'minitest/autorun'
require_relative 'city'
class CityTest < Minitest::Test
  # test random method and make sure the values are withing requirements range
  #
  def test_rand_gold
    # test Nevada
    20.times do |x|
      nevada = City.new('Nevada City', 0, x)
      assert_operator 5, :<=, nevada.max_gold
      assert_operator 0, :>=, nevada.max_gold
      # angel city has max gold between 0 to 4
      # generate seed from 0 to 20 and test the max
      # gold will stay between 0 and 4
      angels = City.new('Angels Camp', 1, x)
      assert_operator 4, :<=, angels.max_gold
      assert_operator 0, :>=, angels.max_gold
      # Coloma gold max gold should be between 0 and 3
      coloma = City.new('Angels Camp', 1, x)
      assert_operator 3, :<=, coloma.max_gold
      assert_operator 0, :>=, coloma.max_gold
    end
  end
end
