require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/activity'

class ActivityTest < Minitest::Test

  def test_it_exists
    a = Activity.new('fun')
    assert_instance_of Activity, a
  end

  def test_it_has_a_name
    a = Activity.new('fun')
    assert_equal 'fun', a.name
  end

  def test_it_can_add_participants
    a = Activity.new('fun')
    a.add_participant('tom', 5)
    participants = {:tom => 5}
    assert_equal participants, a.participants
  end

  def test_it_has_a_base_cost
    a = Activity.new('fun')
    assert_nil a.base_cost
    a.set_base_cost(100)
    assert_equal 100, a.base_cost
  end

  def test_it_has_a_cost_per_participant
    a = Activity.new('fun')
    assert_nil a.cost_per_participant
    a.set_cost_per_participant(10)
    assert_equal 10, a.cost_per_participant
  end

  def test_it_can_calculate_total_cost
    a = Activity.new('fun')
    a.add_participant('tom', 5)
    a.add_participant('bill', 5)
    a.add_participant('fred', 5)
    a.set_base_cost(100)
    a.set_cost_per_participant(10)
    assert_equal 130, a.total_cost
  end

  def test_it_can_determine_fair_shares
    a = Activity.new('fun')
    a.add_participant('tom', 5)
    a.add_participant('bill', 5)
    a.add_participant('fred', 5)
    a.add_participant('frank', 5)
    a.set_base_cost(100)
    a.set_cost_per_participant(10)
    assert_equal 35, a.fair_share
  end

  def test_it_can_determine_owed_amounts
    a = Activity.new('fun')
    a.add_participant('tom', 5)
    a.add_participant('bill', 10)
    a.add_participant('fred', 15)
    a.add_participant('frank', 20)
    a.set_base_cost(100)
    a.set_cost_per_participant(10)
    assert_equal 30, a.balance[:tom]
    assert_equal 25, a.balance[:bill]
    assert_equal 20, a.balance[:fred]
    assert_equal 15, a.balance[:frank]
  end


end
