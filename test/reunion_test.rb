require 'minitest'
require 'minitest/test'
require 'minitest/autorun'
require './lib/reunion'
require './lib/activity'

class ReunionTest < Minitest::Test

  def test_it_exists
    r = Reunion.new
    assert_instance_of Reunion, r
  end

  def test_it_has_a_location
    r = Reunion.new
    assert_nil r.location
    r.add_location('Denver')
    assert_equal 'Denver', r.location
  end

  def test_it_has_activities
    r = Reunion.new
    assert_equal [], r.activities
    games = Activity.new('games')
    r.add_activity(games)
    assert_equal [games], r.activities
  end

  def test_it_has_a_total_cost
    r = Reunion.new
    f = Activity.new('fun')
    f.add_participant('tom', 5)
    f.add_participant('bill', 10)
    f.add_participant('fred', 15)
    f.add_participant('frank', 20)
    f.set_base_cost(100)
    f.set_cost_per_participant(10)
    r.add_activity(f)
    nf = Activity.new('no fun')
    nf.add_participant('tom', 25)
    nf.add_participant('bill', 30)
    nf.add_participant('frank', 15)
    nf.add_participant('debbie', 20)
    nf.set_base_cost(200)
    nf.set_cost_per_participant(20)
    r.add_activity(nf)
    assert_equal 420, r.total_cost
  end

  def test_it_can_calculate_reunion_balances
    r = Reunion.new
    f = Activity.new('fun')
    f.add_participant('tom', 40)
    f.add_participant('bill', 10)
    f.add_participant('fred', 15)
    f.add_participant('frank', 20)
    f.set_base_cost(100)
    f.set_cost_per_participant(10)
    r.add_activity(f)
    nf = Activity.new('no fun')
    nf.add_participant('tom', 25)
    nf.add_participant('bill', 30)
    nf.add_participant('frank', 15)
    nf.add_participant('debbie', 100)
    nf.set_base_cost(200)
    nf.set_cost_per_participant(20)
    r.add_activity(nf)
    balances = {tom: 40,
                bill: 65,
                fred: 20,
                frank: 70,
                debbie: -30
               }
    assert_equal balances, r.final_balances
  end

  def test_it_can_print_balance_sheet
    r = Reunion.new
    f = Activity.new('fun')
    f.add_participant('tom', 40)
    f.add_participant('bill', 10)
    f.add_participant('fred', 15)
    f.add_participant('frank', 20)
    f.set_base_cost(100)
    f.set_cost_per_participant(10)
    r.add_activity(f)
    nf = Activity.new('no fun')
    nf.add_participant('tom', 25)
    nf.add_participant('bill', 30)
    nf.add_participant('frank', 15)
    nf.add_participant('debbie', 100)
    nf.set_base_cost(200)
    nf.set_cost_per_participant(20)
    r.add_activity(nf)
    balance_sheet =
    "Amounts Owed:
Tom = $40
Bill = $65
Fred = $20
Frank = $70
Debbie = $-30
"
    assert_equal balance_sheet, r.balance_sheet
  end

end
