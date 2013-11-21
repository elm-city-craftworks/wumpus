require "set"

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

class Narrator
  def initialize(cave, player)
    @cave   = cave
    @player = player
  end

  def say(message)
    puts message
  end

  def ask(question)
    print "#{question} "
    gets.chomp
  end

  def current_room
    @cave.current_room
  end

  def describe_room
    say "-----------------------------------------"
    say "You are in room #{current_room.number}."

    @player.investigate(current_room) 

    say "Exits go to: #{current_room.exits.join(', ')}"
  end

  def ask_player_to_act
    accepting_player_input do |action, dest|
      case action
      when "m"
        new_room = current_room.neighbor(dest)

        @cave.move_to(new_room) # FIXME: awkward double call here
        @player.enter(new_room) # .........
      when "s"
        if current_room.neighbor(dest).has?(:wumpus)
          finish_story("YOU KILLED THE WUMPUS! GOOD JOB, BUDDY!!!")
        else
          finish_story("YOU SHOT INTO AN EMPTY ROOM. THIS WOKE THE WUMPUS "+
                    "FROM HIS SLUMBER, AND HE GOBBLED YOU UP!")
        end
      end
    end
  end

  def finished?
    !!@ending_message
  end

  def describe_ending
    say "-----------------------------------------"
    say @ending_message
  end

  def finish_story(message)
    @ending_message = message
  end

  private

  def accepting_player_input
    say "-----------------------------------------"
    action = ask("What do you want to do? (m)ove or (s)hoot?")

    unless ["m","s"].include?(action)
      say "INVALID ACTION! TRY AGAIN!"
      return
    end

    dest = ask("Where?").to_i

    unless current_room.exits.include?(dest)
      say "THERE IS NO PATH TO THAT ROOM! TRY AGAIN!"
      return
    end

    yield(action, dest)
  end
end

class Cave
  def initialize
    @rooms        = (1..20).map.with_object({}) { |i, h| h[i] = Room.new(i) }
    @current_room = random_room

    build_dodechadron_layout

    random_room.add(:wumpus)

    3.times { random_room.add(:pit) }
    3.times { random_room.add(:bats) }
  end

  attr_reader :current_room

  def random_room
    @rooms.values.sample
  end

  def move_to(room)
    @current_room = room
  end

  def move(thing, from: raise, to: raise)
    from.remove(thing)
    to.add(thing)
  end

  private

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

class Player
  def initialize
    @senses     = {}
    @encounters = {}
  end

  def sense(thing, &callback)
    @senses[thing] = callback
  end

  def encounter(thing, &callback)
    @encounters[thing] = callback
  end

  def enter(room)
    @encounters.each do |thing, action|
      return(action.call) if room.has?(thing)
    end
  end

  def investigate(room)
    @senses.each do |thing, action|
      if room.neighbors.any? { |room| room.has?(thing) }
        action.call
      end
    end
  end
end

cave     = Cave.new
player   = Player.new
narrator = Narrator.new(cave, player)

# Senses 

player.sense(:bats) do
  narrator.say("You hear a rustling sound nearby") 
end

player.sense(:wumpus) do
  narrator.say("You smell something terrible nearby")
end

player.sense(:pit) do
  narrator.say("You feel a cold wind blowing from a nearby cavern.")
end

# Encounters

player.encounter(:bats) do
  narrator.say "Giant bats whisk you away to a new cavern!"

  new_room = cave.random_room

  cave.move(:bats, from: cave.current_room, to: new_room)
  cave.move_to(new_room)
end

player.encounter(:wumpus) do
  narrator.finish_story("The wumpus ate you up!")
end

player.encounter(:pit) do
  narrator.finish_story("You fell into a bottomless pit. Enjoy the ride!")
end

# Actions 

until narrator.finished?
  narrator.describe_room
  narrator.ask_player_to_act
end

# Completion

narrator.describe_ending

