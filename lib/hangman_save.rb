require 'yaml'

class SaveGame
  attr_accessor :save_files

  def initialize
    @game_saves = scan_dir
  end

  def scan_dir
    Dir.children('savegames')
  end

  def delete_files(index_list)
    index_list.each { |i| File.delete("savegames/#{@game_saves[i.to_i]}") }
  end

  def save_file(object)
    puts 'Please choose a save game name'
    name = gets.chomp
    File.open("savegames/#{name}", 'w') { |file| file.write(object.to_yaml) }
  end

  def handle_save(object)
    if @game_saves.length > 4
      puts 'Saves full, choose comma delimited items to remove:'
      @game_saves.each_with_index { |file, index| puts "#{index} : #{file}" }
      index_list = gets.chomp.split(',')
      delete_files(index_list)
    end
    save_file(object)
  end
end
