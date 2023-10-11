# frozen_string_literal: true

class Player
  attr_reader :name, :kills

  def initialize(name)
    @name = name
    @kills = 0
  end

  def add_kill
    @kills += 1
  end

  def remove_kill
    @kills -= 1
  end
end
