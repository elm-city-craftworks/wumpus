Instructions for DIY Hunt the Wumpus

1) Create a branch of your own to do your work on:

    $ git checkout -b diy_wumpus

2) Download the tests for the `Wumpus::Room` class:

    $ git pull origin room_tests

3) Run the tests and verify that there are new failures:

    $ ruby test/suite.rb

4) Edit `lib/wumpus/room.rb` to get the tests to pass.

5) Download the tests for the `Wumpus::Cave` class:
 
    $ git pull origin cave_tests

6) Run the tests and verify that there are new failures:

    $ ruby test/suite.rb

7) Edit `lib/wumpus/cave.rb` to get the tests to pass.

8) Download the tests for the `Wumpus::Player` class:

    $ git pull origin player_tests

9) Run the tests and verify that there are new failures:

    $ ruby test/suite.rb

10) Edit `lib/wumpus/player.rb` to get the tests to pass.

11) Download the game executable and supporting UI code:

    $ git pull origin game_executable

12) Enjoy a game of Hunt The Wumpus (hopefully):

    $ bin/wumpus

If you get stuck, or you just want to see how Practicing Ruby implemented 
this game, you can always check out the reference implementation:

    $ git checkout origin/reference_implementation
