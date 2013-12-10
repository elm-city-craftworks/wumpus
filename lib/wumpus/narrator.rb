module Wumpus
  class Narrator
    def say(message)
      $stdout.puts message
    end

    def ask(question)
      print "#{question} "
      $stdin.gets.chomp
    end

    def tell_story
      yield until finished?
  
      say "-----------------------------------------"
      describe_ending
    end

    def finish_story(message)
      @ending_message = message
    end
 
    def finished?
      !!@ending_message
    end

    def describe_ending
      say @ending_message
    end
  end
end
