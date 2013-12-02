require_relative "../helper"

describe "A room" do
  let(:room) { Wumpus::Room.new(42) }

  ### IDENTITY ###

  it "has a number" do
    room.number.must_equal(42)
  end

  ### HAZARDS ###

  it "may contain hazards" do 
    # rooms start out empty
    assert room.empty? 

    # hazards can be added
    room.add(:wumpus)
    room.add(:bats)

    # a room with hazards isn't empty
    refute room.empty?

    # hazards can be detected by name
    assert room.has?(:wumpus)
    assert room.has?(:bats)

    refute room.has?(:alf)

    # hazards can be removed
    room.remove(:bats)
    refute room.has?(:bats)
  end

  ### NEIGHBORS ###

  it "has connections to neighbors" do
    neighbors = [2,4,8].each do |i| 
      # create a connection to a neighboring room
      room.connect(Wumpus::Room.new(i)) 

      # a neighbor can be looked up by room number
      room.neighbor(i).number.must_equal(i)

      # Room connections are bidirectional
      room.neighbor(i).neighbor(room.number).must_equal(room)
    end

    # Can get numbers of all neighboring rooms
    room.exits.must_equal([2,4,8])

    # Can grab a random room
    [2,4,8].must_include(room.random_neighbor.number)
  end

  ### SAFETY ###

  it "is not safe if it has hazards" do
    room.add(:wumpus)

    refute room.safe?
  end

  it "is not safe if its neighbors have hazards" do
    [2,4,8].each { |i| room.connect(Wumpus::Room.new(i)) }

    room.random_neighbor.add(:wumpus)

    refute room.safe?
  end

  it "is safe when it and its neighbors have no hazards" do
    [2,4,8].each { |i| room.connect(Wumpus::Room.new(i)) }

    assert room.safe?
  end
end
