class String
  def indices(char)
    index_arr = []
    self.each_char.with_index{ |c, index| index_arr << index if self[index] == char }
    index_arr
  end
end

class Hangman
  attr_accessor :secret
  attr_accessor :result
  attr_accessor :guesses_left
  def initialize
    @secret = File.readlines('5desk.txt').sample.chomp
    @result = Array.new(@secret.length, '_')
    @guesses_left = 10
  end

  def get_guess
    puts 'Please enter your one letter guess'
    gets.chomp
  end

  def update_result(indices, guess)
    indices.each { |index| @result[index] = guess }
  end

  def check_guess(guess)
    puts 'No dice!' && return unless @secret.index(guess)
    @secret.indices(guess)
  end

  def run_game
    while @guesses_left.positive?
      current_guess = get_guess
      indices_of_guess = check_guess(current_guess)
      update_result(indices_of_guess, current_guess) unless indices_of_guess.nil?
      puts @result.join
      puts "Guesses remaining: #{guesses_left}"
    end
  end
# END OF CLASS
end

hangman = Hangman.new
hangman.run_game
