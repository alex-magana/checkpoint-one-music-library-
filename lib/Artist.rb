require_relative '../concerns/concerns_findable.rb'

class Artist

    extend Concerns::Findable

    attr_accessor   :name, :songs

    @@all = []
    
    def initialize(name)
        @name = name
        @songs = []
    end

    def self.create(name)
        Artist.new(name).save
    end
    
    def self.all
        @@all
    end

    def save
        @@all.push(self)
        self
    end

    def self.destroy_all
        @@all.clear()
    end
    
    def add_song(song)
        @songs.push(song) unless @songs.include?song
        song.artist = self unless song.artist == self
    end

    def genres
       # genres_all = []
       # @songs.each do |song|
       #     genres_all.push(song.genre) unless genres_all.include?song.genre
       # end
       # genres_all
       @songs.map { |song| song.genre unless song.genre.nil? }.uniq
    end

end