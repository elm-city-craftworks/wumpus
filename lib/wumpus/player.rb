module Wumpus
  class Player
    def initialize
      raise NotImplementedError, "See lib/wumpus/player.rb"
    end

    attr_reader :room

    def sense(thing, &callback)
      raise NotImplementedError, "See lib/wumpus/player.rb"
    end

    def encounter(thing, &callback)
      raise NotImplementedError, "See lib/wumpus/player.rb"
    end

    def action(thing, &callback)
      raise NotImplementedError, "See lib/wumpus/player.rb"
    end

    def enter(room)
      raise NotImplementedError, "See lib/wumpus/player.rb"
    end

    def explore_room
      raise NotImplementedError, "See lib/wumpus/player.rb"
    end

    def act(action, destination)
      raise NotImplementedError, "See lib/wumpus/player.rb"
    end
  end
end
