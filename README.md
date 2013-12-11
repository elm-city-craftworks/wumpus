Instructions for DIY Hunt the Wumpus

1) Download the tests for the `Wumpus::Room` class:

    $ git pull origin room_tests

2) Run the tests and verify that there are new failures:

    $ ruby test/suite.rb

3) Edit `lib/wumpus/room.rb` to get the tests to pass.

4) Download the tests for the `Wumpus::Cave` class:
 
    $ git pull origin cave_tests

5) Run the tests and verify that there are new failures:

    $ ruby test/suite.rb

6) Edit `lib/wumpus/cave.rb` to get the tests to pass.

7) Download the tests for the `Wumpus::Player` class:

    $ git pull origin player_tests

8) Run the tests and verify that there are new failures:

    $ ruby test/suite.rb

8) Edit `lib/wumpus/player.rb` to get the tests to pass.

9) Download the game executable and supporting UI code:

    $ git pull origin game_executable

10) Enjoy a game of Hunt The Wumpus (hopefully):

    $ bin/wumpus

If you get stuck, or you just want to see how Practicing Ruby implemented 
this game, you can always check out the reference implementation:

    $ git checkout origin/reference_implementation
