=begin
Accepts a file path of mp3 files. A #files method that will 
return all of the filenames. The .import method imports 
all the files from the library and creates the Song objects.
=end

require_relative 'song.rb'

class MusicImporter
  
  attr_accessor   :path, :file_names
  
  def initialize(path)
    @path = path
  end
  
  def files
    Dir.chdir(path) do
      Dir.glob("*.mp3")
    end
  end
  
  def import
    files.each { |file| Song.create_from_filename(file) }
  end
  
end