=begin 
Initializes with an optional path to the music, but defaults 
to ./db/mp3s. It creates a MusicImporter and imports the music.

The #call method that starts the CLI and asks the user for 
input. Check out the tests for specifics
=end

require_relative 'music_importer.rb'

class MusicLibraryController

    attr_accessor   :path, :music_importer

    @@song_names = nil
    @@songs_all = Song.all 
    @@artists_all = Artist.all
    @@genres_all = Genre.all
    @@commands = {"list songs" => :list_songs, 
        "list artists" => :list_artists, 
        "list genres" => :list_genres, 
        "play song" => :play_song,
        "list artist" => :list_artist,
        "list genre" => :list_genre}

    PROMPT = "music_library>"

    def initialize(path = "./db/mp3s")
        @path = path
        @music_importer = MusicImporter.new(path)
        @music_importer.import
        @@song_names = self.music_importer.file_names
    end

    def call
        introduction
        
        while true
            print PROMPT
            user_input = self.send(:gets).chomp
            break if user_input.to_s == "exit" 
            self.command_evaluate(user_input)
        end
        
    end

    def introduction    
        print "Music Library\n\n\t\tUsage:\n" \
        "\tlist songs\t: List all songs.\n" \
        "\tlist artists\t: List all artists.\n" \
        "\tlist genres\t: List all genres.\n" \
        "\tplay song\t: Play a song.\n" \
        "\tlist artist\t: List the artist.\n" \
        "\tlist genre\t: List the genre.\n"
    end

    def command_evaluate(command_name)
        self.command_execute(@@commands[command_name.to_s])
    end

    def command_execute(command_name)
        self.send(command_name)
    end

    def list_songs
        @@song_names.each do |song|
            puts "#{@@song_names.index(song) + 1}. #{song.gsub(".mp3", "")}"
        end
    end

    def list_artists
        @@artists_all.each do |artist|
            puts "#{@@artists_all.index(artist) + 1}. #{artist.name}"
        end
    end

    def list_genres
        @@genres_all.each do |genre|
            puts "#{@@genres_all.index(genre) + 1}. #{genre.name}"
        end
    end

    def play_song
        puts "Enter the number of the song to play."
        song_number = self.send(:gets).chomp.to_i
        puts "Playing #{(@@song_names[song_number - 1]).gsub(".mp3", "").strip}"
    end

    def list_artist
        puts "Enter the name of the artist."
        artist_name = self.send(:gets).chomp
        artist = Artist.find_by_name(artist_name)
        artist.songs.each { |song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}" }
        # require 'pry'; binding.pry;
    end

    def list_genre
        puts "Enter the genre whose songs you would like listed."
        genre_name = self.send(:gets).chomp
        genre = Genre.find_by_name(genre_name)
        genre.songs.each { |song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}" }
        # require 'pry'; binding.pry;
    end

end

# mlc = MusicLibraryController.new("./spec/fixtures/mp3s")
# mlc.call