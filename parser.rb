# frozen_string_literal: true

require './lib/log_reader'
require './lib/line_reader'
require './objects/game'
require './objects/player'

class Parser
  attr_reader :games

  WORLD_KILLER = '<world>'

  def initialize
    @log = LogReader.open_log_file
    @games = []
  end

  def parse
    @log.each do |log_line|
      line = LineReader.new(log_line)

      if line.new_game?
        add_game
      elsif line.player_event?
        add_player(line)
      elsif line.kill?
        add_kill(line)
      end
    end
  end

  private

  def last_game
    @games.last
  end

  def add_game
    @games << Game.new(@games.length + 1)
  end

  def add_player(line)
    player = Player.new(line.player)

    return if last_game.players.include?(player.name)

    last_game.players << player.name
    last_game.kills[player.name] = player
  end

  def add_kill(line)
    last_game.add_kill

    killer = line.killer
    victim = line.victim

    if killer == WORLD_KILLER
      last_game.kills[victim].remove_kill
    else
      last_game.kills[killer].add_kill
    end
  end
end
