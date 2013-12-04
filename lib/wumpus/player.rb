module Wumpus
  class Player
    def initialize
      @senses     = {}
      @encounters = {}
      @actions    = {}
    end

    attr_reader :room

    def sense(thing, &callback)
      @senses[thing] = callback
    end

    def encounter(thing, &callback)
      @encounters[thing] = callback
    end

    def action(thing, &callback)
      @actions[thing] = callback
    end

    def enter(room)
      @room = room

      @encounters.each do |thing, action|
        return(action.call) if room.has?(thing)
      end
    end

    def explore_room
      @senses.each do |thing, action|
        action.call if @room.neighbors.any? { |e| e.has?(thing) }
      end
    end

    def act(action, destination)
      @actions[action].call(destination)
    end
  end
end
