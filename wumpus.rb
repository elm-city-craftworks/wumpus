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

class Narrator
  def initialize(current_room, wumpus_room)
    @current_room = current_room
    @wumpus_room  = wumpus_room
  end

  def describes_room
    puts "-----------------------------------------"
    puts "You are in room #{@current_room.number}."

    if exits.include?(@wumpus_room.number)
      puts "You smell something terrible."
    end

    puts "Exits go to: #{exits.join(', ')}"
  end

  def asks_player_to_act
    accepting_player_input do |action, dest|
      case action
      when "m"
        @current_room = @current_room.find_neighbor(dest)

        if @current_room == @wumpus_room
          game_over("The wumpus gobbled you up. GAME OVER!")
        end
      when "s"
        if @current_room.find_neighbor(dest) == @wumpus_room
         game_over("YOU KILLED THE WUMPUS! GOOD JOB, BUDDY!!!")
        else
          puts "Your arrow didn't hit anything. Try a different room?"
        end
      end
    end
  end

  def finished?
    !!@ending_message
  end

  def describe_ending
    puts "-----------------------------------------"
    puts @ending_message
  end

  private

  def game_over(message)
    @ending_message = message
  end

  def exits
    @current_room.neighboring_room_numbers
  end

  def accepting_player_input
    puts "-----------------------------------------"
    print "What do you want to do? (m)ove or (s)hoot? "
    action = gets.chomp

    unless ["m","s"].include?(action)
      puts "INVALID ACTION! TRY AGAIN!"
      return
    end

    print "Where? "
    dest = gets.to_i

    unless exits.include?(dest)
      puts "THERE IS NO PATH TO THAT ROOM! TRY AGAIN!"
      return
    end

    yield(action, dest)
  end
end

rooms = (1..10).map{ |i| Room.new(i) }
rooms.each_cons(2) { |a,b| a.connect(b) }

current_room = rooms.first
wumpus_room  = rooms[5..-1].sample

narrator = Narrator.new(current_room, wumpus_room)

until narrator.finished?
  narrator.describes_room
  narrator.asks_player_to_act
end

narrator.describe_ending

