# frozen_string_literal: true

require './lib/log_reader'
require './objects/game'
require './objects/player'

class Parser
  attr_reader :games

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
end
