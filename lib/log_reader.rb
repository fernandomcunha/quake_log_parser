# frozen_string_literal: true

class LogReader
  attr_reader :log

  def self.open_log_file
    new.open_log_file
  end

  def initialize
    @log = open_log_file
  end

  def open_log_file
    File.open('./quake_game.log')
  end
end
