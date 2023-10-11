# frozen_string_literal: true

require './lib/log_reader'
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
    @log.each do |line|
      if new_game?(line)
        @games << Game.new(@games.length + 1)
      elsif player_event?(line)
        player = Player.new(get_player(line))

        next if last_game.players.include?(player.name)

        last_game.players << player.name
        last_game.kills[player.name] = player
      elsif kill?(line)
        last_game.add_kill

        killer = get_killer(line)
        victim = get_victim(line)

        if killer == WORLD_KILLER
          last_game.kills[victim].remove_kill
        else
          last_game.kills[killer].add_kill
        end
      end
    end
  end

  private

  def last_game
    @games.last
  end

  def new_game?(line)
    line.match(/(?:^|\W)InitGame(?:$|\W)/) ? true : false
  end

  def player_event?(line)
    line.match(/(?:^|\W)ClientUserinfoChanged(?:$|\W)/) ? true : false
  end

  def get_player(line)
    line.match(/((?<=n\\).*?(?=\\t))/)[0]
  end

  def kill?(line)
    line.match(/(?:^|\W)Kill(?:$|\W)/) ? true : false
  end

  def get_killer(line)
    line.match(/([^:]+).(?=\skilled)/)[0].strip
  end

  def get_victim(line)
    line.match(/((?<=killed\s).*(?=\sby))/)[0]
  end
end
