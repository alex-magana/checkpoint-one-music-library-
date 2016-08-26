# Accepts a name upon initialization and set that property correctly. The name 
# property should be readable and writeable by the object.

# Contains a class variable @@all that is set to an empty array and is 
# prepared to store all saved instances. This class variable should be 
# accessible via the class method .all.

# It responds to a #save method that adds the instance itself into the 
# class variable @@all.

# The class empties it's @@all array via a class method .destroy_all.

# Implements a custom constructor .create that instantiates 
# an instance using .new but also evokes #save on that instance, forcing 
# it to persist immediately.

class Song

  extend Concerns::Findable
  extend Concerns::Generic
  include Concerns::GenericInstance

  attr_accessor   :name
  attr_reader     :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def artist=(artist_instance)
    @artist = artist_instance
    @artist.add_song(self)
  end

  def genre=(genre_instance)
    @genre = genre_instance
    @genre.songs.push(self) unless @genre.songs.include? self
  end

  def self.new_from_filename(file_name)
    song_details = file_name.gsub(".mp3", "").split(" - ")
    if song_details.size == 3
      artist = Artist.find_or_create_by_name((song_details[0]).strip)
      genre = Genre.find_or_create_by_name((song_details[2]).strip)
      song = Song.new((song_details[1]).strip, artist, genre)
    else
      song = Song.new((song_details[0]).strip)
    end
  end

  def self.create_from_filename(file_name)
    new_from_filename(file_name).save
  end

end

