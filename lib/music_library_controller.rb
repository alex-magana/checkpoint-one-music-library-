# Initializes with an optional path to the music, but defaults 
# to ./db/mp3s. It creates a MusicImporter and imports the music.

# The #call method that starts the CLI and asks the user for 
# input. Check out the tests for specifics

class MusicLibraryController
  attr_accessor :path
  attr_reader :music_library_view

  COMMANDS = {"list songs" => :list_songs,
    "list artists" => :list_artists,
    "list genres" => :list_genres,
    "play song" => :play_song,
    "list artist" => :list_artist,
    "list genre" => :list_genre,
    "help" => :help}

  PROMPT = "santuri>".colorize(:yellow)

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
    send((COMMANDS[command_name]).to_s)
  end

  def list_songs
    Song.all.each_with_index { |song, i| music_library_view.
      list_songs(song, i) }
  end

  def list_artists
    Artist.all.each_with_index { |artist, i| music_library_view.
      list_artists(artist, i) }
  end

  def list_genres
    Genre.all.each_with_index { |genre, i| music_library_view.
      list_genres(genre, i) }
  end

  def play_song
    puts "Enter the number of the song to play."
    song_number = gets.chomp.to_i
    match = /[a-zA-Z]+/.match(song_number.to_s)
    if (song_number <= Song.all.size) && (match == nil)
      music_library_view.play_song(Song.all[song_number - 1], true)
    else
      music_library_view.play_song
    end
  end

  def list_artist
    puts "Enter the name of the artist."
    artist = Artist.find_by_name(gets.chomp)
    if artist
      artist.songs.each { |song| music_library_view.list_artist(song, true) }
    else
      music_library_view.list_artist
    end
  end

  def list_genre
    puts "Enter the genre whose songs you would like listed."
    genre = Genre.find_by_name(gets.chomp)
    if genre
      genre.songs.each { |song| music_library_view.list_genre(song, true) }
    else
      music_library_view.list_genre
    end    
  end

  def help
    music_library_view.help
  end

  def method_missing(method_name, *args, &block)
    music_library_view.help(true)
  end
end