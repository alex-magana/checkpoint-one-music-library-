=begin 
Initializes with an optional path to the music, but defaults 
to ./db/mp3s. It creates a MusicImporter and imports the music.

The #call method that starts the CLI and asks the user for 
input. Check out the tests for specifics
=end

require_relative 'music_importer.rb'

class MusicLibraryController

    attr_accessor   :path, :music_importer

    @@commands = {"list songs" => :list_songs, 
        "list artists" => :list_artists, 
        "list genres" => :list_genres, 
        "play song" => :play_song,
        "list artist" => :list_artist,
        "list genre" => :list_genre}

    PROMPT = "music_library>"

    def initialize(path = "./db/mp3s")
        @path = path
        MusicImporter.new(path).import
    end

    def call
        introduction
        
        while true
            print PROMPT
            user_input = self.send(:gets).chomp
            break if user_input == "exit" 
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
        self.command_execute(@@commands[command_name])
    end

    def command_execute(command_name)
        self.send(command_name)
    end

    def list_songs
        Song.all.each_with_index do |song, i|
            puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end
    end

    def list_artists
        Artist.all.each_with_index do |artist, i|
            puts "#{i + 1}. #{artist.name}"
        end
    end

    def list_genres
        Genre.all.each_with_index do |genre, i|
            puts "#{i + 1}. #{genre.name}"
        end
    end

    def play_song
        puts "Enter the number of the song to play."
        song_number = self.send(:gets).chomp.to_i
        song = Song.all[song_number - 1]
        puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end

    def list_artist
        puts "Enter the name of the artist."
        artist_name = self.send(:gets).chomp
        artist = Artist.find_by_name(artist_name)
        artist.songs.each { |song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}" }
        
    end

    def list_genre
        puts "Enter the genre whose songs you would like listed."
        genre_name = self.send(:gets).chomp
        genre = Genre.find_by_name(genre_name)
        genre.songs.each { |song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}" }
    end

end