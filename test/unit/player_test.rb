require_relative "../helper"

describe "the player" do
  it "can sense nearby hazards when exploring rooms" do
    cave = Wumpus::Cave.new
    room = cave.entrance

    room.random_neighbor.add(:bats)
    room.random_neighbor.add(:wumpus)

    output = []

    player = Wumpus::Player.new
    player.enter(room)

    player.sense(:bats) do
      output << "You hear a rustling sound"
    end

    player.sense(:wumpus) do
      output << "You smell something terrible"
    end

    player.explore_room

    output.must_equal(["You hear a rustling sound", "You smell something terrible"])

    cave.room_with(:bats).remove(:bats)
    output.clear

    player.explore_room
    output.must_equal(["You smell something terrible"])
  end

  it "can encounter hazards when entering a room" do
    safe_room   = Wumpus::Room.new(42)

    unsafe_room = Wumpus::Room.new(99)
    unsafe_room.add(:wumpus)

    effects = []
    
    player = Wumpus::Player.new
    
    player.encounter(:wumpus) do
      effects << "The wumpus ate you up!"
    end

    player.enter(safe_room)

    assert effects.empty?

    player.enter(unsafe_room)

    effects.must_equal(["The wumpus ate you up!"])
  end

  it "can perform actions" do
    player = Wumpus::Player.new

    room_a = Wumpus::Room.new(42)
    room_b = Wumpus::Room.new(99)

    player.enter(room_a)

    player.room.must_equal(room_a)

    player.action(:move) do |destination|
      player.enter(destination)
    end

    player.act(:move, room_b)
    player.room.must_equal(room_b)
  end
end
