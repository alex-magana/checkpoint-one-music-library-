# Initializes with an optional path to the music, but defaults 
# to ./db/mp3s. It creates a MusicImporter and imports the music.

# The #call method that starts the CLI and asks the user for 
# input. Check out the tests for specifics

class MusicLibraryController

  attr_accessor   :path
  attr_reader     :music_library_view

  COMMANDS = {"list songs" => :list_songs,
    "list artists" => :list_artists,
    "list genres" => :list_genres,
    "play song" => :play_song,
    "list artist" => :list_artist,
    "list genre" => :list_genre,
    "help" => :help}

  PROMPT = "santuri>"

  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
    @music_library_view = MusicLibraryView.new
  end

  def call
    introduction

    while true
      print PROMPT
      user_input = gets.chomp.strip.downcase
      break if user_input == "exit" 
      self.command_execute(user_input)
    end
  end

  def introduction
    music_library_view.introduction
  end

  def command_execute(command_name)
    if COMMANDS.include? command_name
      self.send(COMMANDS[command_name])
    else
      puts "Invalid command.\n"
      help
    end
  end

  def list_songs
    music_library_view.list_songs
  end

  def list_artists
    music_library_view.list_artists
  end

  def list_genres
    music_library_view.list_genres
  end

  def play_song
    puts "Enter the number of the song to play."
    song_number = gets.chomp.to_i
    music_library_view.play_song(song_number)
  end

  def list_artist
    puts "Enter the name of the artist."
    artist_name = gets.chomp
    music_library_view.list_artist(artist_name)
  end

  def list_genre
    puts "Enter the genre whose songs you would like listed."
    genre_name = gets.chomp
    music_library_view.list_genre(genre_name)
  end

  def help
    introduction
  end

end