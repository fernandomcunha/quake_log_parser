# frozen_string_literal: true

require './log_object'

class LogParser
  attr_reader :output

  def initialize
    @log_object = LogObject.new
    @output = {}
  end

  def parse_log
    @log_object.parse

    @log_object.games.each do |game|
      create_game(game)
    end

    @output
  end

  private

  def create_game(game)
    @output["game_#{game.id}"] = {
      total_kills: game.total_kills,
      players: game.players,
      kills: kills(game),
      kills_by_means: game.kills_by_means,
      ranking: ranking(game)
    }
  end

  def kills(game)
    game.kills.transform_values(&:kills)
  end

  def ranking(game)
    sort_kills = kills(game).sort_by { |name, kills| [-kills, name] }.to_h
    sort_kills.each_with_object({}).with_index do |((name, _kills), hash), index|
      hash[index + 1] = name
    end
  end
end
