require_relative 'hangman_save'

class String
  def indices(char)
    index_arr = []
    self.each_char.with_index{ |_c, index| index_arr << index if self[index].downcase == char.downcase }
    index_arr
  end
end

class Hangman
  attr_accessor :secret
  attr_accessor :result
  attr_accessor :guesses_left
  attr_accessor :win

  def initialize
    @secret = File.readlines('5desk.txt').sample.chomp
    @result = Array.new(@secret.length, '_')
    @guesses_left = 10
  end

  def save_game?
    puts 'Would you like to save the game?'
    gets.chomp.match(/[yY]/) ? true : false
  end

  def user_guess
    puts 'Please enter your one letter guess'
    gets.chomp
  end

  def update_result(indices, guess)
    indices.each { |index| @result[index] = guess }
  end

  def check_guess(guess)
    if @secret.downcase.index(guess)
      @secret.indices(guess)
    else
      puts 'No Dice!'
      @guesses_left -= 1
      nil
    end
  end

  def run_game
    while @guesses_left.positive?
      to_save = save_game?
      SaveGame.handle_save(self) if to_save
      abort('You Win!') unless @result.include?('_')
      current_guess = user_guess
      indices_of_guess = check_guess(current_guess)
      update_result(indices_of_guess, current_guess) unless indices_of_guess.nil?
      puts @result.join
      puts "Guesses remaining: #{@guesses_left}"
      puts "The secret word was #{@secret}" if @guesses_left.zero?
    end
  end
# END OF CLASS
end

hangman = Hangman.new
hangman.run_game
