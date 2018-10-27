require_relative 'rules'
require 'minitest/autorun'

  # testing Rules class

class RulesTest < Minitest::Test


  # UNIT TESTS FOR METHOD pos_int?(input)
  # Equivalence classes:
  # input = 0..INFINITY -> returns true
  # input = -INFINITY..-1 -> returns false
  # input = (not a number) -> returns false

  # If a negative value is given for input , then false is returned.
  def test_negative_val
    set_rules = Rules::new
    input = '-11'
    actual = set_rules.pos_int? input
    expected = false
    assert_equal expected, actual
  end

  # If a positive value is given for input , then true is returned.
  def test_positive_val
    set_rule = Rules.new
    actual = set_rule.pos_int? '4654'
    expected = true
    assert_equal expected, actual
  end

  # if invalid value, such as string, is given for input then false is returned
  # EDGE CASE
  def test_invalid_val
    set_rule = Rules.new
    actual = set_rule.pos_int? 'quack'
    expected = false
    assert_equal expected, actual
  end


  # if invalid value, such as float number , is given for input then false is returned
  # test_float_number
  # # EDGE CASE
  def test_float_val
    set_rule = Rules.new
    actual = set_rule.pos_int? '1.2'
    expected = false
    assert_equal expected, actual
  end

  # UNIT TESTS FOR METHOD pos_neg_int?(input)
  # Equivalence classes:
  # input =  -INFINITY.. +INFINITY -> returns true
  # input = (not a number) -> returns false

  # If a negative value is given for input , then false is returned.
  def test_neg_val
    set_rules = Rules::new
    input = '-11'
    actual = set_rules.pos_neg_int? input
    expected = true
    assert_equal expected, actual
  end
  # If a positive value is given for input , then true is returned.
  def test_pos_val
    set_rule = Rules.new
    actual = set_rule.pos_int? '4654'
    expected = true
    assert_equal expected, actual
  end

  # If a invalid value is given for input , then false is returned.
  # EDGE CASE
  def test_invalid_val_symbol
    set_rule = Rules.new
    actual = set_rule.pos_int? '-'
    expected = false
    assert_equal expected, actual
  end

  # UNIT TESTS FOR METHOD valid_input(seed, number_of_pros )
  # Equivalence classes:
  # seed = -INFINITY..+INFINITY  AND number_of_pros [0 -- +INFINITY] => returns true
  # Seed NOT [-INFINITY..+INFINITY] OR number_of_pros NOT [0 -- +INFINITY] =>false

  # input = (not a number) -> returns false

  # if seed is positive and number of prospectors are positive, then true returned
  def test_pos_seed_pos_pros
    set_rule = Rules.new
    actual = set_rule.valid_input? '123','453'
    expected = true
    assert_equal expected, actual
  end
  # if seed is negative and number of prospectors are positive, then true returned
  def test_neg_seed_pos_pros
    set_rule = Rules.new
    actual = set_rule.valid_input? '-123','453'
    expected = true
    assert_equal expected, actual
  end
  # if seed is negative and number of prospectors is negative, then false returned
  def test_neg_seed_neg_pros
    set_rule = Rules.new
    actual = set_rule.valid_input? '-123','-453'
    expected = false
    assert_equal expected, actual
  end

  # if seed is negative and number of prospectors is negative, then false returned
  def test_pros_seed_invalid
    set_rule = Rules.new
    actual = set_rule.valid_input? '-323','123A'
    expected = false
    assert_equal expected, actual
  end


  # UNIT TESTS FOR METHOD first_3_cities(id, prng, pross)
  # The method should stop after visit 3 cities

  def test_first_3_cities
    map = Map.new
    set_rule = Rules.new
    prng = Random.new 12
    id =0
    prospectors =[]
    prospectors[id] = Prospector.new id, prng
    prospectors[id].current_city = map.cities[2]

    set_rule.first_3_cities id, prng,prospectors

    assert_equal 3 ,prospectors[id].visited_num

  end
  # UNIT TESTS FOR METHOD final_2_cities(id, prng, pross)
  # The method should stop after visit 5 cities

  def test_final_2_cities
    map = Map.new
    set_rule = Rules.new
    prng = Random.new 12
    id =0
    prospectors =[]
    prospectors[id] = Prospector.new id, prng
    prospectors[id].current_city = map.cities[2]

    set_rule.final_2_cities id, prng,prospectors
    assert_equal 5 ,prospectors[id].visited_num

  end

end
