# frozen_string_literal: true

class LineReader
  def initialize(line)
    @line = line
  end

  def new_game?
    @line.match(/(?:^|\W)InitGame(?:$|\W)/) ? true : false
  end

  def player_event?
    @line.match(/(?:^|\W)ClientUserinfoChanged(?:$|\W)/) ? true : false
  end

  def player
    @line.match(/((?<=n\\).*?(?=\\t))/)[0]
  end

  def kill?
    @line.match(/(?:^|\W)Kill(?:$|\W)/) ? true : false
  end

  def killer
    @line.match(/([^:]+).(?=\skilled)/)[0].strip
  end

  def victim
    @line.match(/((?<=killed\s).*(?=\sby))/)[0]
  end
end
