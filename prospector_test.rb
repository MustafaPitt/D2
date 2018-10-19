require 'test/unit'
require 'map.rb'
require 'prospector.rb'

class ProspectorTest < Minitest::Test

  # test start method
  def test_start
    seed = 10
    num_of_pros = 4
    pros = Prospector.new num_of_pros, seed
    map = Map.new seed
    output = 'Prospector 1 starting in Sutter Creek.'
    assert_equal output, pros.start('Sutter Creek', pros.pros_id)
  end

end