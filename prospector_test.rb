require 'minitest/autorun'
require_relative 'map'
require_relative 'city'
require_relative 'prospector'

# Test prospector class
#
class ProspectorTest < Minitest::Test
  # test start method. make sure using start method from prospector
  # will print the appropriate message as
  # "prospector 1 starting in Sutter Creek.'" after passing prospector id and
  # city name to start with

  def test_start
    seed = 10
    prng = Random.new seed
    id = 1
    pros = Prospector.new id, prng
    map = Map.new
    expected = "Prospector 1 starting in Sutter Creek.\n"
    actual = pros.get_start_msg map.cities[2].name, 1
    assert_equal expected, actual, 'check how to compare between 2 string\n'
  end

  # test search for gold and silver
  # search_for_gold_or_silver
  # Equivalence classes:
  # case 1: gold = 0 silver  = 0
  # case 2: gold > 0 silver = 0
  # singular and plural ounces
  # case 3: gold = 0 silver > 0
  # case 4  gold > 0 silver > 0

  # case1 : when there is no silver or gold
  # print the appropriate message and return
  #
  # true for has to leave boolean
  def test_gold_and_silver_is_zero
    seed = 10
    id = 1
    prng = Random.new(seed)
    pros = Prospector.new id, prng
    Map.new
    max_gold = 0
    max_silver = 0
    actual = pros.get_msg_search_first_3_ir 'Midas', max_gold, max_silver
    expected = "Found no precious metals in Midas.\n"
    assert_equal expected, actual, 'check it should be correct\n'
    assert_equal true, pros.has_to_leave
  end

  # case 2 A if gold = 1, but no silver (silver = 0)
  # check singular
  #
  def test_gold_without_silver_singular
    seed = 10
    id = 1
    prng = Random.new(seed)
    pros = Prospector.new id, prng
    max_silver = 0
    max_gold = 1
    actual = pros.get_msg_search_first_3_ir 'Midas', max_gold, max_silver
    expected = "Found 1 ounce of gold in Midas.\n"
    assert_equal expected, actual, 'check it should be correct\n'
  end

  # case 2 B if gold  > 1, but no silver (silver = 0)
  # check singular
  #
  def test_gold_without_silver_plural
    seed = 10
    id = 1
    pros = Prospector.new id, seed
    max_silver = 0
    max_gold = 3
    actual = pros.get_msg_search_first_3_ir 'Midas', max_gold, max_silver
    expected = "Found 3 ounces of gold in Midas.\n"
    assert_equal expected, actual
  end

  # case 3 A if silver = 1, but no gold (gold = 0)
  # check singular
  #
  def test_silver_without_gold_singular
    seed = 10
    id = 1
    pros = Prospector.new id, seed
    max_silver = 1
    max_gold = 0
    actual = pros.get_msg_search_first_3_ir 'Midas', max_gold, max_silver
    expected = "Found 1 ounce of silver in Midas.\n"
    assert_equal expected, actual
  end

  # case 3 B if silver > 1, but no gold (gold = 0)
  # check singular
  #
  def test_silver_without_gold_plural
    seed = 10
    id = 1
    pros = Prospector.new id, seed
    max_silver = 3
    max_gold = 0
    actual = pros.get_msg_search_first_3_ir 'Midas', max_gold, max_silver
    expected = "Found 3 ounces of silver in Midas.\n"
    assert_equal expected, actual, 'check it should be correct\n'
  end

  # this method will print the msge for moving the prospector
  # from one city to another

  # @return [msg]
  def test_move_msg
    map = Map.new
    pros = Prospector.new 1, 12

    actual = pros.move_msg map.cities[2].name, map.cities[4].name, 1, 0
    expected = "Heading from Sutter Creek to Coloma, holding 1 ounce of gold and 0 ounces of silver.\n"
    assert_equal expected, actual
  end

  # test the get_rand
  # make sure all values withing requirement
  # range
  #
  def test_rand_gold_nevada
    # max gold between 0 and 5
    prng = Random.new(15)
    pros = Prospector.new 1, prng
    map = Map.new
    200.times do
      actual = pros.get_ran_gold map.cities[0].id, prng, map.cities[0].max_gold
      assert_operator 5, :>=, actual
      assert_operator 0, :<=, actual
    end
  end

  def test_rand_gold_angel_camp
    # max gold between 0 and 4
    prng = Random.new(15)
    pros = Prospector.new 1, prng
    map = Map.new
    200.times do
      actual = pros.get_ran_gold map.cities[1].id, prng, map.cities[1].max_gold
      assert_operator 4, :>=, actual
      assert_operator 0, :<=, actual
    end
  end

  def test_rand_gold_sutter
    # max gold between 0 and 2
    prng = Random.new(15)
    pros = Prospector.new 1, prng
    map = Map.new
    200.times do
      actual = pros.get_ran_gold map.cities[2].id, prng, map.cities[2].max_gold
      assert_operator 2, :>=, actual
      assert_operator 0, :<=, actual
    end
  end

  def test_rand_gold_virginia
    # max gold between 0 and 3
    prng = Random.new(15)
    pros = Prospector.new 1, prng
    map = Map.new
    200.times do
      actual = pros.get_ran_gold map.cities[3].id, prng, map.cities[3].max_gold
      assert_operator 3, :>=, actual
      assert_operator 0, :<=, actual
    end
  end

  #
  #
  #
  #
  # Test get random for silver
  #
  def test_rand_silver_virginia
    # max silver should be between 0 and 3
    prng = Random.new(15)
    pros = Prospector.new 1, prng
    map = Map.new
    200.times do
      actual = pros.get_ran_silver map.cities[3].id, prng, map.cities[3].max_sliver
      assert_operator 3, :>=, actual
      assert_operator 0, :<=, actual
    end
  end

  def test_rand_silver_midas
    # max silver should be between 0 and 5
    prng = Random.new(15)
    pros = Prospector.new 1, prng
    map = Map.new
    200.times do
      actual = pros.get_ran_silver map.cities[5].id, prng, map.cities[5].max_sliver
      assert_operator 5, :>=, actual
      assert_operator 0, :<=, actual
    end
  end

  def test_rand_silver_eldorado
    # max silver should be between 0 and 10
    prng = Random.new(15)
    pros = Prospector.new 1, prng
    map = Map.new
    200.times do
      actual = pros.get_ran_silver map.cities[6].id, prng, map.cities[6].max_sliver
      assert_operator 10, :>=, actual
      assert_operator 0, :<=, actual
    end
  end

  def test_rand_silver_coloma
    # max silver should be 0
    prng = Random.new(15)
    pros = Prospector.new 1, prng
    map = Map.new
    actual = pros.get_ran_silver map.cities[4].id, prng, map.cities[4].max_sliver
    assert_equal 0, actual
  end




end
