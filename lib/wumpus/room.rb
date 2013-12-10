module Wumpus
  class Room
    def initialize(number)
      raise NotImplementedError, "See lib/wumpus/room.rb"
    end

    attr_reader :number, :neighbors

    def add(thing)
      raise NotImplementedError, "See lib/wumpus/room.rb"
    end

    def remove(thing)
      raise NotImplementedError, "See lib/wumpus/room.rb"
    end

    def has?(thing)
      raise NotImplementedError, "See lib/wumpus/room.rb"
    end

    def empty?
      raise NotImplementedError, "See lib/wumpus/room.rb"
    end

    def safe?
      raise NotImplementedError, "See lib/wumpus/room.rb"
    end

    def connect(other_room)
      raise NotImplementedError, "See lib/wumpus/room.rb"
    end

    def exits
      raise NotImplementedError, "See lib/wumpus/room.rb"
    end

    def neighbor(number)
      raise NotImplementedError, "See lib/wumpus/room.rb"
    end

    def random_neighbor
      raise NotImplementedError, "See lib/wumpus/room.rb"
    end
  end
end
