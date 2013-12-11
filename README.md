A simplified implementation of Gregory Yob's [Hunt the Wumpus][wumpus], written 
as an example for Practicing Ruby, Issue 7.7. No external dependencies other
than Ruby 2.0 are required to use this software.

To play a game, run the following command:

    $ ruby bin/wumpus

See the game transcript below for an example of how to play:

    You are in room 1.
    Exits go to: 2, 8, 5
    -----------------------------------------
    What do you want to do? (m)ove or (s)hoot? m
    Where? 2
    -----------------------------------------
    You are in room 2.
    Exits go to: 1, 10, 3
    -----------------------------------------
    What do you want to do? (m)ove or (s)hoot? m
    Where? 10
    -----------------------------------------
    You are in room 10.
    Exits go to: 2, 11, 9

    What do you want to do? (m)ove or (s)hoot? m
    Where? 11
    -----------------------------------------
    You are in room 11.
    Exits go to: 10, 8, 20
    -----------------------------------------
    What do you want to do? (m)ove or (s)hoot? m
    Where? 20
    -----------------------------------------
    You are in room 20.
    You feel a cold wind blowing from a nearby cavern.
    Exits go to: 11, 19, 17
    -----------------------------------------
    What do you want to do? (m)ove or (s)hoot? m
    Where? 11
    -----------------------------------------
    You are in room 11.
    Exits go to: 10, 8, 20
    -----------------------------------------
    What do you want to do? (m)ove or (s)hoot? m
    Where? 8
    -----------------------------------------
    You are in room 8.
    You smell something terrible nearby
    Exits go to: 11, 1, 7
    -----------------------------------------
    What do you want to do? (m)ove or (s)hoot? s
    Where? 7
    -----------------------------------------
    YOU KILLED THE WUMPUS! GOOD JOB, BUDDY!!!

 If you have any questions, please email gregory@practicingruby.com
