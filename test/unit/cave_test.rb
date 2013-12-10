require "set"

require_relative "../helper"

describe "A cave" do
  let(:cave)  { Wumpus::Cave.dodecahedron }
  let(:rooms) { (1..20).map { |i| cave.room(i) } }
  
  it "has 20 rooms that each connect to exactly three other rooms" do
    rooms.each do |room|
      room.neighbors.count.must_equal(3)
      
      assert room.neighbors.all? { |e| e.neighbors.include?(room) }
    end
  end

  it "can select rooms at random" do
    sampling = Set.new

    must_eventually("randomly select each room") do
      new_room = cave.random_room 
      sampling << new_room

      sampling == Set[*rooms] 
    end
  end

  it "can move hazards from one room to another" do
    room      = cave.random_room
    neighbor  = room.neighbors.first

    room.add(:bats)

    assert room.has?(:bats)
    refute neighbor.has?(:bats)

    cave.move(:bats, :from => room, :to => neighbor)

    refute room.has?(:bats)
    assert neighbor.has?(:bats)
  end

  it "can add hazards at random to a specfic number rooms" do
    cave.add_hazard(:bats, 3)

    rooms.select { |e| e.has?(:bats) }.count.must_equal(3)
  end

  it "can find a room with a particular hazard" do
    cave.add_hazard(:wumpus, 1)

    assert cave.room_with(:wumpus).has?(:wumpus)
  end

  it "can find a safe room to serve as an entrance" do
    cave.add_hazard(:wumpus, 1)
    cave.add_hazard(:pit, 3)
    cave.add_hazard(:bats, 3)

    entrance = cave.entrance

    assert entrance.safe?
  end
end
