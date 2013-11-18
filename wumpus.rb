#
#    1 - 2 - 3 - 4 - 5 - 6 - 7 - 8 - 9 - 10
# 

require "set"

class Room
  def initialize(number)
    @number    = number
    @neighbors = Set.new
  end

  attr_reader :number, :neighbors

  def connect(other_room)
    neighbors << other_room

    other_room.neighbors << self
  end

  def neighboring_room_numbers 
    neighbors.map { |e| e.number }
  end

  def find_neighbor(number)
    neighbors.find { |e| e.number == number }
  end
end

rooms = (1..10).map{ |i| Room.new(i) }
rooms.each_cons(2) { |a,b| a.connect(b) }

room  = rooms.first

loop do
  puts room.number

  break if room.number == 10
  room = room.find_neighbor(room.neighboring_room_numbers.max)
end









=begin
wumpus_room  = rand(2..10)
current_room = 1

loop do
  puts

  if current_room == 0
    puts "You escaped the cave unharmed,"
    puts "but the wumpus still lurks in the shadows. GAME OVER!"
    exit
  elsif current_room == wumpus_room
    puts "The wumpus gobbled you up. GAME OVER!"
    exit
  else
    if (current_room - wumpus_room).abs == 1
      puts "You smell something terrible."
    end

    puts "You are in room #{current_room}."
    puts "Exits go to #{current_room - 1} and #{current_room + 1}."

    puts "What do you want to do? (m)ove or (s)hoot?"
    action = gets.chomp

    unless ["m","s"].include?(action)
      puts "INVALID ACTION! TRY AGAIN!"
      next
    end

    print "Where? "
    room = gets.to_i

    unless (current_room - room).abs == 1
      puts "THERE IS NO PATH TO THAT ROOM! TRY AGAIN!"
      next
    end

    case action
    when "m"
      current_room = room
    when "s"
      if room == wumpus_room
        puts "YOU KILLED THE WUMPUS! GOOD JOB, BUDDY!!!"
        exit
      else
        puts "Your arrow didn't hit anything. Try a different room?"
      end
    end
  end
end
=end
