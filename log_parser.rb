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
      kills: add_kills(game)
    }
  end

  def add_kills(game)
    game.kills.transform_values(&:kills)
  end
end
