# frozen_string_literal: true

require './lib/log_reader'
require './objects/game'

class Parser
  def initialize
    @log = LogReader.open_log_file
    @games = []
  end

  def parse
    @log.each do |line|
      @games << Game.new(@games.length + 1) if new_game?(line)
    end
  end

  private

  def new_game?(line)
    line.match(/(?:^|\W)InitGame(?:$|\W)/) ? true : false
  end
end
