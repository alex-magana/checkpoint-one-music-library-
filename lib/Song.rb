require_relative 'Artist.rb'
require_relative 'Genre.rb'

class Song

    attr_accessor   :name 
    attr_reader     :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre   
    end

    def self.create(name)
        Song.new(name).save
    end

    def self.all
        @@all
    end

    def artist=(_artist)
        @artist = _artist
        @artist.add_song(self)
    end

    def genre=(_genre)
        @genre = _genre
        @genre.songs.push(self) unless @genre.songs.include?self
    end

    def save
        @@all.push(self)
        self
    end

    def self.destroy_all
        @@all.clear()
    end

    def self.find_by_name(name)
        # search_result = nil
        # @@all.each do |song|
        #     if song.name == name
        #         search_result = song
        #     end
        # end
        # search_result
        @@all.detect { |song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        # search_result = nil
        # @@all.each do |song|
        #     if 
        #     end
        # end
        song = find_by_name(name)
        song = Song.create(name) unless song
        song
    end

    def self.new_from_filename(file_name)
        song_details = file_name.split(" - ")
        artist = Artist.all.detect {|artist| artist.name == (song_details[0]).strip} || Artist.create((song_details[0]).strip)
        genre = Genre.all.detect { |genre| genre.name == ((song_details[2]).gsub(".mp3", "")).strip } || Genre.create(((song_details[2]).gsub(".mp3", "")).strip)
        song = Song.new((song_details[1]).strip, artist, genre).save
    end

    def self.create_from_filename(file_name)
        new_from_filename(file_name)
    end

end