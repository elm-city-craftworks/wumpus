require "minitest/autorun"

require "strscan"
require_relative "../lib/wumpus"

class MiniTest::Unit::TestCase
  def must_eventually(message, n=1000)
    n.times { yield and return pass }
    flunk("Expected to #{message}, but didn't")
  end

  def with_stdin
    stdin = $stdin             
    $stdin, write = IO.pipe    
    capture_io { yield(write) }               
  ensure
    write.close                
    $stdin = stdin             
  end

  def expect_string_sequence(out, *patterns)
    scanner = StringScanner.new(out)

    patterns.each do |pattern|
      scanner.scan_until(pattern) or 
        flunk("Didn't find pattern #{pattern.inspect} in sequence")
    end

    pass
  end
end
