require_relative 'MusicImporter.rb'

class MusicLibraryController

	attr_accessor	:path, :music_importer

	def initialize(path = "./db/mp3s")
		@path = path
		@music_importer = MusicImporter.new(path)
		@music_importer.import
	end

	def call
		# "list songs", "exit"
		# "list artists", "exit"
		# "list genres", "exit"
		# "play song", "1",  "exit"
		# "list artist", "Real Estate", "exit"
		# "list genre", "dance", "exit"
		
		print "Music Library\n\tUsage:\n" \
		"list songs\t: List all songs.\n" \
		"list artists\t: List all artists.\n" \
		"list genres\t: List all genres.\n" \
		"play song\t: Play a song.\n" \
		"list artist\t: List the artist.\n" \
		"list genre\t: List the genre.\n"
		
		while true
			print "music_library>"
			
			user_input = self.send(:gets).chomp

			case user_input.to_s
			when "list songs"
				song_names = self.music_importer.file_names
				song_names.each do |song|
					puts "#{song_names.index(song) + 1}. #{song.gsub(".mp3", "")}"
				end
			when "list artists"
				artists_all = Artist.all 
				artists_all.each do |artist|
					puts "#{artists_all.index(artist) + 1}. #{artist.name}"
				end
			when "list genres"
				genres_all = Genre.all
				genres_all.each do |genre|
					puts "#{genres_all.index(genre) + 1}. #{genre.name}"
				end
			when "play song"
				puts "Enter the number of the song to play."
				song_number = self.send(:gets).chomp.to_i
				song_names = self.music_importer.file_names
				puts "Playing #{(song_names[song_number - 1]).gsub(".mp3", "").strip}"
			when "list artist"
				puts "Enter the name of the artist."
				artist_name = self.send(:gets).chomp
				songs_all = Song.all 
				songs_all.each { |song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}" if song.artist.name == artist_name }
			when "list genre"
				puts "Enter the genre whose songs you would like listed."
				genre_name = self.send(:gets).chomp
				songs_all = Song.all
				songs_all.each { |song| puts "#{song.artist.name} - #{song.name} - #{song.genre.name}" if song.genre.name == genre_name }
			when "exit"
				puts "exit"
				break
				#exit(0)
			else
				break
				#exit(0)
			end
		end
	end
end

# mlc = MusicLibraryController.new("./spec/fixtures/mp3s")
# mlc.call
# require 'pry'; binding.pry;