require "json"

module Wumpus
  class Cave
    def self.dodecahedron
      from_json("#{Wumpus::DATA_DIR}/dodecahedron.json")
    end

    def self.from_json(filename)
      new(JSON.parse(File.read(filename)))
    end

    def initialize(edges)
      # FIXME: Can probably be changed to use an arbitrary number of rooms.
      # The only reason it's not set up that way now is because of the
      # brittleness of test/acceptance.rb
      @rooms = (1..20).map.with_object({}) { |i, h| h[i] = Room.new(i) }

      edges.each { |a,b| @rooms[a].connect(@rooms[b]) }
    end

    def add_hazard(thing, count)
      count.times do
        room = random_room

        redo if room.has?(thing)

        room.add(thing) 
      end
    end

    def random_room
      @rooms.values.sample
    end

    def move(thing, from: raise, to: raise)
      from.remove(thing)
      to.add(thing)
    end

    def room_with(thing)
      @rooms.values.find { |e| e.has?(thing) }
    end

    def entrance
      @entrance ||= @rooms.values.find(&:safe?)
    end

    def room(number)
      @rooms[number]
    end
  end
end
