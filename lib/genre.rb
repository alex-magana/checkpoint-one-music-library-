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
        @songs.map { |song| song.artist unless song.artist.nil? }.uniq
    end

end