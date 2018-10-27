require 'minitest/autorun'
require_relative 'map'
require_relative 'city'
require_relative 'prospector'

# Test prospector class
#
class ProspectorTest < Minitest::Test
  # # UNIT TESTS FOR METHOD
  # "prospector 1 starting in Sutter Creek." after passing prospector id and
  # city name to start with

  def test_start
    seed = 10
    prng = Random.new seed
    id = 1
    pros = Prospector.new id, prng
    map = Map.new
    pros.current_city = map.cities[2]

    expected = "Prospector 1 starting in Sutter Creek.\n"
    actual = pros.get_start_msg pros.current_city.name, 1
    assert_equal expected, actual, 'check how to compare between 2 string\n'
  end

  # # UNIT TESTS FOR METHOD search_for_gold_or_silver()
  # search_for_gold_or_silver(city, gold, silver)
  # Equivalence classes:
  # case 1: gold = 0 silver = 0 ==> "Found no precious metals in #{city name}.\n"
  # case 2: gold = 1 silver = 0 ==> "Found 1 ounce of gold in #{city name}.\n"
  # case 3: gold = 0 silver = 1 ==> "Found 1 ounce of silver in #{city name}\n"
  # case 4: gold > 1, silver = 0 ==> "Found {# gold} ounces of gold in #{city name}.\n"
  # case 5: gold = 0, silver > 1 ==> "Found {# silver} ounces of silver in #{city name}.\n"

  # case1 : when there is no silver or gold
  # return string ==> "the Found no precious metals in {name of city}" and set has_to_leave boolean
  # true for has to leave boolean
  def test_gold_and_silver_is_zero
    seed = 10
    id = 1
    prng = Random.new(seed)
    pros = Prospector.new id, prng
    city = Minitest::Mock.new 'Mock City'
    def city.name
      'Midas'
    end

    def city.max_gold
      0
    end

    def city.max_silver
      0
    end

    actual = pros.get_msg_search_first_3_ir city.name, city.max_gold, city.max_silver
    expected = "Found no precious metals in Midas.\n"
    assert_equal expected, actual, 'check it should be correct\n'
    assert_equal true, pros.has_to_leave
  end

  # case 2 A if gold = 1, but no silver (silver = 0)
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

  # case 3: gold = 0 silver = 1
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

  # case 4 if gold  > 1, but no silver (silver = 0)
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

  # case 5  if silver > 1 and (gold = 0)
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
    prospector = Minitest::Mock.new('Mock prospector')
    # mock object for map to

    # make to mock cities name
    def prospector.current_city
      'Sutter Creek'
    end

    def prospector.dest_city
      'Midas'
    end
    pros = Prospector.new 1, 123

    # use the mock cities to test the method
    actual = pros.move_msg prospector.current_city, prospector.dest_city, 1, 0
    expected = "Heading from Sutter Creek to Midas, holding 1 ounces of gold and 0 ounces of silver.\n"
    assert_equal expected, actual
  end

  # UNIT TESTS FOR METHOD get_ran_gold(id_city, prng, max_gold)
  # Return a random value between 0 and max_gold based on seed passed through
  # prng for a specific city through param id
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

  # UNIT TESTS FOR METHOD fo get_ran_silver(id_city, prng, max_gold)
  # Return a random value between 0 and max_silver based on seed passed through
  # prng for a specific city through param id
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

  # UNIT TESTS FOR METHOD increment_count_days
  # increment_count_days each time calling this function will increase the @count_days by 1

  def test_increment_count_days
    seed = 10
    prng = Random.new seed
    id = 1
    pros = Prospector.new id, prng
    pros.increment_count_days
    assert_equal 1, pros.count_days
  end

  # UNIT TESTS FOR METHOD increment_count_days
  # increment_visit each time calling this function will increase the @visited_num by 1
  def test_increment_visit
    seed = 10
    prng = Random.new seed
    id = 1
    pros = Prospector.new id, prng
    pros.increment_visit
    assert_equal 1, pros.visited_num
  end

  #  # UNIT TESTS FOR METHOD for get_another_id(prng, max_con).  Return random number up to 'max_con'  connections array
  # testing a couple cities checking the random connections id

  # default testing Testing the method will return up to the array length
  def default_test
    seed = 10
    prng = Random.new seed
    id = 1
    pros = Prospector.new id, prng
    # Mock an array of connections
    city = Minitest::Mock.new('Mock Map')
    def city.connection
      ['mock city 1', 'mock city 2', 'mock city 3']
    end
    200.times do
      actual = pros.get_another_id prng, city.connection.length
      assert_operator 3, :>=, actual
      assert_operator 0, :<=, actual
    end
  end

  def test_get_another_id_for_virg
    # testing nevada has 4 connections [0--3]
    seed = 10
    prng = Random.new seed
    id = 1
    pros = Prospector.new id, prng
    map = Map.new
    pros.current_city = map.cities[3]

    200.times do
      actual = pros.get_another_id prng, pros.current_city.connections.length
      assert_operator 3, :>=, actual
      assert_operator 0, :<=, actual
    end
  end

  # testing Angel Camp has 3 connections [0--2]
  def test_get_another_id_for_angel
    # testing nevada has 4 connections [0--3]
    seed = 10
    prng = Random.new seed
    id = 1
    pros = Prospector.new id, prng
    map = Map.new
    pros.current_city = map.cities[1]

    200.times do
      actual = pros.get_another_id prng, pros.current_city.connections.length
      assert_operator 2, :>=, actual
      assert_operator 0, :<=, actual
    end
  end

  # testing Coloma has 3 connections [0--2]
  # return random number [0--1]
  def test_get_another_id_for_coloma
    seed = 10
    prng = Random.new seed
    id = 1
    pros = Prospector.new id, prng
    map = Map.new
    pros.current_city = map.cities[4]

    200.times do
      actual = pros.get_another_id prng, pros.current_city.connections.length
      assert_operator 1, :>=, actual
      assert_operator 0, :<=, actual
    end
  end

  # UNIT TESTS FOR METHOD test_collect_metals(gold, silver)
  # it should add collected metals that earned by prospector to the total global variables t_gold and t_silver
  def test_collect_metals
    seed = 10
    prng = Random.new seed
    id = 1
    pros = Prospector.new id, prng
    gold = 5
    silver = 5
    pros.collect_metals gold, silver
    assert_equal 5, pros.t_gold
    assert_equal 5, pros.t_silver

    # add another values
    pros.collect_metals gold, silver
    assert_equal 10, pros.t_gold
    assert_equal 10, pros.t_silver
  end

  # Test convert_metals_to_cash

  # testing gold
  def test_convert_cash_g
    seed = 10
    prng = Random.new seed
    id = 1
    pros = Prospector.new id, prng

    gold = 2
    silver = 0
    actual = pros.convert_metals_to_cash gold, silver
    expected = 41.34
    assert_equal expected, actual
  end

  # testing silver
  def test_convert_cash_s
    seed = 10
    prng = Random.new seed
    id = 1
    pros = Prospector.new id, prng

    gold = 0
    silver = 2
    actual = pros.convert_metals_to_cash gold, silver
    expected = 2.62
    assert_equal expected, actual
  end

  # testing converting gold and silver
  def test_convert_cash_g_s
    seed = 10
    prng = Random.new seed
    id = 1
    pros = Prospector.new id, prng
    gold = 2
    silver = 2
    actual = pros.convert_metals_to_cash gold, silver
    expected = 43.96
    assert_equal expected, actual
  end
end
