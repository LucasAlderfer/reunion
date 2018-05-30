require 'pry'
class Reunion
  attr_reader :location, :activities

  def initialize
    @location = nil
    @activities = []
  end

  def add_location(location)
    @location = location
  end

  def add_activity(activity)
    @activities << activity
  end

  def total_cost
    @activities.reduce(0) do |total, activity|
      total += activity.total_cost
    end
  end

  def final_balances
    balances = Hash.new{0}
    @activities.each do |activity|
      activity.balance.each do |name, paid|
        balances[name] += paid
      end
    end
    balances
  end

  def balance_sheet
    sheet = "Amounts Owed:\n"
    final_balances.each do |name, balance|
      sheet += "#{name.to_s.capitalize} = $#{balance}\n"
    end
    sheet
  end
end
