require "json"

module Wumpus
  class Cave
    def self.dodecahedron
      raise NotImplementedError, "See lib/wumpus/cave.rb"
    end

    def self.from_json(filename)
      raise NotImplementedError, "See lib/wumpus/cave.rb"
    end

    def initialize(edges)
      raise NotImplementedError, "See lib/wumpus/cave.rb"
    end

    def add_hazard(thing, count)
      raise NotImplementedError, "See lib/wumpus/cave.rb"
    end

    def random_room
      raise NotImplementedError, "See lib/wumpus/cave.rb"
    end

    def move(thing, from: raise, to: raise)
      raise NotImplementedError, "See lib/wumpus/cave.rb"
    end

    def room_with(thing)
      raise NotImplementedError, "See lib/wumpus/cave.rb"
    end

    def entrance
      raise NotImplementedError, "See lib/wumpus/cave.rb"
    end

    def room(number)
      raise NotImplementedError, "See lib/wumpus/cave.rb"
    end
  end
end
