class Hangman
  attr_accessor :secret
  attr_accessor :blanks
  def initialize
    @secret = secret
    @blanks = []
  end

  def random_word
    @secret = File.readlines('5desk.txt').sample
  end

  def blank_num
    @secret.length.times do
      blanks.push('_')
    end
  end
end

hangman = Hangman.new
puts hangman.random_word
hangman.blank_num
puts hangman.blanks.join(' ')
