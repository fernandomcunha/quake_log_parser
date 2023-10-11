# frozen_string_literal: true

class Game
  attr_reader :id, :total_kills
  attr_accessor :players, :kills

  def initialize(id)
    @id = id
    @total_kills = 0
    @players = []
    @kills = {}
  end

  def add_kill
    @total_kills += 1
  end
end
