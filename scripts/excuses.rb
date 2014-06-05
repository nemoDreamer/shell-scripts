#!/usr/bin/env ruby -w

# --------------------------------------------------
# CLASS EXTENSIONS
# --------------------------------------------------

class String
  ##
  # Cheap e
  def to_a sep = "\n"
    self.strip.split(sep).map { |v| v.strip }
  end
end

class Array
  def rand n = 1
    set = self.clone
    output = []
    n.times do |i|
      r = Random.rand(set.length)
      output.push set.delete_at r
    end

    if n === 1
      output.pop
    else
      output
    end
  end
end

# --------------------------------------------------
# DATA
# --------------------------------------------------

subject = [
  ["My dog", "its"],
  ["A homeless person", "their"],
  ["My daughter", "her"],
  ["My son", "his"],
  ["My wife's mother-in-law", "her"],
  ["A horde of rabid penguins", "their"],
  ["Two wild buffalo", "their"],
  ["My long lost love", "my"],
  ["My doctor", "his"],
  ["The cable guy", "his"],
  ["Jesus H. Christ himself", "his"],
  ["I", "my"]
]

action = %q[
  ate
  pooed on
  bit
  crashed into
  exploded all over
  ran into
  was sick on
  was hit by
].to_a

object = [
  ["homework", true],
  ["daughter", true],
  ["son", true],
  ["the subway", false],
  ["a pole", false],
  ["a ten ton truck", false],
  ["my arm", false]
  ["my toe", false]
  ["my head", false]
]

# --------------------------------------------------
# RUN!
# --------------------------------------------------

25.times do
  my_subject = subject.rand
  my_action = action.rand
  my_object = object.rand

  output = [
    my_subject[0],
    my_action,
    (!my_object[1] ? '' : Random.rand(2) === 1 ? my_subject[1] : 'my'),
    my_object[0],
  ]

  puts output.join(' ').sub(/\s{2,}/, ' ')
end
