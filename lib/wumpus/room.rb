module Wumpus
  class Room
    def initialize(number)
      @number    = number
      @neighbors = []
      @hazards   = []
    end

    attr_reader :number, :neighbors

    def add(thing)
      @hazards << thing
    end

    def remove(thing)
      @hazards.delete(thing)
    end

    def has?(thing)
      @hazards.include?(thing)
    end

    def empty?
      @hazards.empty?
    end

    def safe?
      empty? && neighbors.all? { |e| e.empty? }
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

    def random_neighbor
      neighbors.sample
    end
  end
end
