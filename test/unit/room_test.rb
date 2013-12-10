require_relative "../helper"

describe "A room" do
  let(:room) { Wumpus::Room.new(12) }

  it "has a number" do
    room.number.must_equal(12)
  end

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

  describe "with neighbors" do
    let(:exit_numbers) { [11, 3, 7] }

    before do
      exit_numbers.each { |i| room.connect(Wumpus::Room.new(i)) }
    end

    it "has two-way connections to neighbors" do
      exit_numbers.each do |i| 
        # a neighbor can be looked up by room number
        room.neighbor(i).number.must_equal(i)

        # Room connections are bidirectional
        room.neighbor(i).neighbor(room.number).must_equal(room)
      end
    end

    it "knows the numbers of all neighboring rooms" do
      room.exits.must_equal(exit_numbers)
    end

    it "can choose a neighbor randomly" do
      exit_numbers.must_include(room.random_neighbor.number)
    end
    
    it "is not safe if it has hazards" do
      room.add(:wumpus)

      refute room.safe?
    end

    it "is not safe if its neighbors have hazards" do
      room.random_neighbor.add(:wumpus)

      refute room.safe?
    end

    it "is safe when it and its neighbors have no hazards" do
      assert room.safe?
    end
  end
end
