require "minitest/autorun"

require "simplecov"

SimpleCov.start do
  add_filter "/test/"
end

require_relative "../lib/wumpus"
