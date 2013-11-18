#
#    1 - 2 - 3 - 4 - 5 - 6 - 7 - 8 - 9 - 10
# 

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
    puts "You are in room #{current_room}."
    puts "Exits go to #{current_room - 1} and #{current_room + 1}."
    print "Where do you want to go? "

    choice = gets.to_i

    if (current_room - choice).abs == 1
      current_room = choice
    else
      puts "THERE IS NO PATH TO THAT ROOM! TRY AGAIN!"
    end
  end
end
