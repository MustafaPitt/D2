require_relative 'rules'
require 'minitest/autorun'

  # testing Rules class

class RulesTest < Minitest::Test
  # TESTING has_letter_or_symbol
  # has letter or symbol method should return true if
  # the input contains any char letters from [a-z],[A-Z]
  # or !@#$%^&*()-+... et
  #
  def test_string_input
    set_rule = Rules.new
    actual = set_rule.has_letter_or_symbol 'BB', 'AB'
    expected = true
    assert_equal expected, actual
  end

  # test input with string and digit
  #
  def test_symbol_input
    set_rule = Rules.new
    actual = set_rule.has_letter_or_symbol '#', '$'
    expected = true
    assert_equal expected, actual
  end

  # test_float_number
  def test_float_string
    set_rule = Rules.new
    actual = set_rule.has_letter_or_symbol '1.23', '-156'
    expected = true
    assert_equal expected, actual
  end

  # test if integer end with chars

  def test_integer_end_with_char
    set_rule = Rules.new
    actual = set_rule.has_letter_or_symbol '156LK', '156FD'
    expected = true
    assert_equal expected, actual
  end

  # edge case testing empty string

  def test_empty_string
    set_rule = Rules.new
    actual = set_rule.has_letter_or_symbol '', ''
    expected = true
    assert_equal expected, actual
  end

  # test integer string should return false
  def test_integer_string
    set_rule = Rules.new
    actual = set_rule.has_letter_or_symbol '156', '156'
    expected = false
    assert_equal expected, actual
  end
end
