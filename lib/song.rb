=begin 
Accepts a name upon initialization and set that property correctly. The name 
property should be readable and writeable by the object.

Contains a class variable @@all that is set to an empty array and is 
prepared to store all saved instances. This class variable should be 
accessible via the class method .all.

It responds to a #save method that adds the instance itself into the 
class variable @@all.

The class empties it's @@all array via a class method .destroy_all.

Implements a custom constructor .create that instantiates 
an instance using .new but also evokes #save on that instance, forcing 
it to persist immediately.
=end

require_relative 'artist.rb'
require_relative 'genre.rb'
require_relative '../concerns/concerns_findable.rb'

class Song

    # extend Concerns::Findable

    attr_accessor   :name, :artist, :genre

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
        @genre.songs.push(self) unless @genre.songs.include? self
    end

    def save
        @@all.push(self)
        self
    end

    def self.destroy_all
        @@all.clear()
    end

    # use Concerns::Findable to implement find_by_name 
    def self.find_by_name(name)
        @@all.detect { |song| song.name == name}
    end

    # use Concerns::Findable to implement find_or_create_by_name
    def self.find_or_create_by_name(name)
        song = find_by_name(name)
        song = Song.create(name) unless song
        song
    end

    def self.new_from_filename(file_name)
        song_details = file_name.split(" - ")
        #use Concerns::Findable to detect artist
        artist = Artist.all.detect {|artist| artist.name == (song_details[0]).strip} || Artist.create((song_details[0]).strip)
        #use Concerns::Findable to detect genre
        genre = Genre.all.detect { |genre| genre.name == ((song_details[2]).gsub(".mp3", "")).strip } || Genre.create(((song_details[2]).gsub(".mp3", "")).strip)
        song = Song.new((song_details[1]).strip, artist, genre)
    end

    def self.create_from_filename(file_name)
        new_from_filename(file_name).save
    end

end