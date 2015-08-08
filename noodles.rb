class Noodles
  def initialize
    @dictionary = {}
  end

  def analyze_text(text)
    depth = 2
    current_words = Array.new(depth)
    text_array = text.split(" ")
    while(text_array.length>0)
      next_word = text_array.shift
      add_words(current_words.dup, next_word)
      current_words.push next_word
      current_words.shift
    end
  end

  def add_words(preceding, followedby)
    raise "Preceding must be an array" unless preceding.is_a?(Array)
    raise "Followedby must be string" unless followedby.is_a?(String)
    @dictionary[preceding] ||= []
    @dictionary[preceding].push followedby
  end

  def generate_sentance
    depth = 2
    current_words = Array.new(depth)
    sentence_array = []
    loop do
      sentence_array.push current_words.first
      last_word = sentence_array.last
      if is_end_word?(last_word)
        break
      end
      next_words = @dictionary[current_words]
      if next_words == nil
        last_word.concat(".")
        break
      end
      next_word = next_words.sample
      puts "G #{current_words} -> #{next_word}"
      current_words.push next_word
      current_words.shift
    end
    sentence_array.join(" ")
  end

  def is_end_word?(word)
    word != nil && word.split("").last == "."
  end

  def print
    puts @dictionary
  end
end


noodle = Noodles.new
noodle.analyze_text("Hello! My name is Filip and I like pie. I also like to sing and dance. My home town has a bridge and three cows. I like to buy three dollar pony.")
noodle.print
puts noodle.generate_sentance
