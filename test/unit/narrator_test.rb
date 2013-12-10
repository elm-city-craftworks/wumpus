require_relative "../helper"

describe "the narrator" do
  it "can ask for input" do
    narrator = Wumpus::Narrator.new

    with_stdin do |user|
      user.puts("m")

      narrator.ask("What do you want to do? (m)ove or (s)hoot?").must_equal("m")
    end
  end

  it "can say things" do
    narrator = Wumpus::Narrator.new

    -> { narrator.say("Well hello there, stranger!") }
       .must_output("Well hello there, stranger!\n")
  end

  it "knows when the story is over" do
    narrator = Wumpus::Narrator.new

    refute narrator.finished?

    narrator.finish_story("It's done!")
    
    assert narrator.finished?

    -> { narrator.describe_ending }.must_output("It's done!\n")
  end

  it "knows how to tell a story from beginning to end" do
    narrator = Wumpus::Narrator.new

    chapters = (1..5).to_a

    out, err = capture_io do
      narrator.tell_story do
        narrator.say("Thus begins chapter #{chapters.shift}")

        if chapters.empty?
          narrator.finish_story("And they all lived happily ever after!")
        end
      end
    end

    expect_string_sequence(out, 
      /chapter 1/, /chapter 2/, /chapter 3/, /chapter 4/, /chapter 5/,
      /And they all lived happily ever after!/)
  end
end
