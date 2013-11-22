module Wumpus
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
end
