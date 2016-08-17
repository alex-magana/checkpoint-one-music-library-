require_relative '../concerns/concerns_findable.rb'

class Genre

    extend Concerns::Findable

    attr_accessor   :name, :songs

    @@all = []
    
    def initialize(name)
        @name = name
        @songs = []
    end

    def self.create(name)
        Genre.new(name).save
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

    def artists
        # artists_all = []
        # @songs.each do |song|
        #     artists_all.push(song.artist) unless artists_all.include?song.artist
        # end
        # artists_all
        @songs.map { |song| song.artist unless song.artist.nil? }.uniq
    end

end