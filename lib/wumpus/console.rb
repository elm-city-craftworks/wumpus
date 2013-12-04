module Wumpus
  class Console
    def initialize(player, narrator)
      @player   = player
      @narrator = narrator
    end

    def show_room_description
      @narrator.say "-----------------------------------------"
      @narrator.say "You are in room #{@player.room.number}."

      @player.explore_room

      @narrator.say "Exits go to: #{@player.room.exits.join(', ')}"
    end

    def ask_player_to_act
      actions = {"m" => :move, "s" => :shoot, "i" => :inspect }
      
      accepting_player_input do |command, room_number| 
        @player.act(actions[command], @player.room.neighbor(room_number))
      end
    end

    private

    def accepting_player_input
      @narrator.say "-----------------------------------------"
      command = @narrator.ask("What do you want to do? (m)ove or (s)hoot?")

      unless ["m","s"].include?(command)
        @narrator.say "INVALID ACTION! TRY AGAIN!"
        return
      end

      dest = @narrator.ask("Where?").to_i

      unless @player.room.exits.include?(dest)
        @narrator.say "THERE IS NO PATH TO THAT ROOM! TRY AGAIN!"
        return
      end

      yield(command, dest)
    end
  end
end
