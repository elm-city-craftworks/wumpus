require "set"

module Wumpus
  class Room
    def initialize(number)
      @number    = number
      @neighbors = Set.new
      @contents  = []
    end

    attr_reader :number, :neighbors

    def add(thing)
      @contents.push(thing)
    end

    def remove(thing)
      @contents.delete(thing)
    end

    def has?(thing)
      @contents.include?(thing)
    end

    def connect(other_room)
      neighbors << other_room

      other_room.neighbors << self
    end

    def exits
      neighbors.map { |e| e.number }
    end

    def neighbor(number)
      neighbors.find { |e| e.number == number }
    end
  end
end
