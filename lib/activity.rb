class Activity
  attr_reader :name, :participants, :base_cost, :cost_per_participant

  def initialize(name)
    @name = name
    @participants = {}
    @base_cost = nil
    @cost_per_participant = nil
  end

  def add_participant(name, paid)
    @participants[name.to_sym] = paid
  end

  def set_base_cost(cost)
    @base_cost = cost
  end

  def set_cost_per_participant(cost)
    @cost_per_participant = cost
  end

  def total_cost
    @base_cost + (@cost_per_participant * @participants.count)
  end

  def fair_share
    total_cost / (@participants.count)
  end

  def balance
    balance = {}
    @participants.each do |name, paid|
      balance[name] = fair_share - paid
    end
    balance
  end

end
