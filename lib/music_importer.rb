require_relative 'song.rb'

class MusicImporter

    attr_accessor   :path, :file_names

    def initialize(path)
        @path = path
        @file_names = []
    end

    def files
        Dir::entries(path).select { |_file| @file_names.push(_file) if File.file?"#{path}/#{_file}"}
        @file_names
    end

    def import
        files_all = files
        files_all.each { |file| Song.create_from_filename(file) }
    end

end