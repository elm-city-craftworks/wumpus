module Wumpus
  class Cave
    def initialize
      @rooms = (1..20).map.with_object({}) { |i, h| h[i] = Room.new(i) }
      build_dodechadron_layout
    end

    def add_hazard(thing, count)
      count.times { random_room.add(thing) }
    end

    def random_room
      @rooms.values.sample
    end

    def move(thing, from: raise, to: raise)
      from.remove(thing)
      to.add(thing)
    end

    def entrance
      @entrance ||= @rooms.values.find(&:safe?)
    end


    def build_dodechadron_layout
      connections = [[1,2],[2,10],[10,11],[11,8],[8,1],
                     [1,5],[2,3],[9,10],[20,11],[7,8],
                     [5,4],[4,3],[3,12],[12,9],[9,19],
                     [19,20],[20,17],[17,7],[7,6],[6,5],
                     [4,14],[12,13],[18,19],[16,17],
                     [15,6],[14,13],[13,18],[18,16],
                     [16,15],[15,14]]

      connections.each { |a,b| @rooms[a].connect(@rooms[b]) }
    end
  end
end
