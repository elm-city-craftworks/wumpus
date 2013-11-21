module Wumpus
  class Player
    def initialize
      @senses     = {}
      @encounters = {}
    end

    def sense(thing, &callback)
      @senses[thing] = callback
    end

    def encounter(thing, &callback)
      @encounters[thing] = callback
    end

    def enter(room)
      @encounters.each do |thing, action|
        return(action.call) if room.has?(thing)
      end
    end

    def investigate(room)
      @senses.each do |thing, action|
        if room.neighbors.any? { |room| room.has?(thing) }
          action.call
        end
      end
    end
  end
end
