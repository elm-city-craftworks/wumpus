require "simplecov"

SimpleCov.start { add_filter("/test/") }

require_relative "unit/room_test"
require_relative "unit/cave_test"
require_relative "unit/player_test"
require_relative "unit/narrator_test"
