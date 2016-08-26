# This class implements the view part of the MVC structure.
# The methods defined here are invoked MusicLibraryController

class MusicLibraryView

  def introduction
    print "Music Library\n\n\t\tUsage:\n" \
      "\tlist songs\t: List all songs.\n" \
      "\tlist artists\t: List all artists.\n" \
      "\tlist genres\t: List all genres.\n" \
      "\tplay song\t: Play a song.\n" \
      "\tlist artist\t: List the artist.\n" \
      "\tlist genre\t: List the genre.\n" \
      "\texit\t\t: Quit the program.\n" \
      "\thelp\t\t: View available commands.\n"
  end

  def list_songs
    Song.all.each_with_index do |song, i|
      puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    Artist.all.each_with_index do |artist, i|
      puts "#{i + 1}. #{artist.name}"
    end
  end

  def list_genres
    Genre.all.each_with_index do |genre, i|
      puts "#{i + 1}. #{genre.name}"
    end
  end

  def play_song(song_number)
    match = /[a-zA-Z]+/.match(song_number.to_s)
    if (song_number <= Song.all.size) && (match == nil)
      song = Song.all[song_number - 1]
      puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
    else
      puts "The song you requested does not exist. Enter" \
       "numbers 1 through #{Song.all.size}."
    end
  end

  def list_artist(artist_name)
    artist = Artist.find_by_name(artist_name)
    if artist
      artist.songs.each { |song| puts "#{song.artist.name} " \
        "- #{song.name} - #{song.genre.name}" }
    else
      "The artist you requested does not exist. Use command " \
        "'list artists' to view available artists."
    end
  end

  def list_genre(genre_name)
    genre = Genre.find_by_name(genre_name)
    if genre
      genre.songs.each { |song| puts "#{song.artist.name} - " \
        "#{song.name} - #{song.genre.name}" }
    else
      "The genre you requested does not exist. Use command " \
        "'list genres' to view available artists."
    end
  end

  def help
    introduction
  end

end