require_relative 'song.rb'

class MusicImporter

    attr_accessor   :path, :file_names

    def initialize(path)
        @path = path
    end

    def files
        Dir::entries(path).select { |_file| File.file?"#{path}/#{_file}"}
    end

    def import
        files.each { |file| Song.create_from_filename(file) }
    end

end