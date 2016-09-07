# This class implements the view part of the MVC structure.
# The methods defined here are invoked MusicLibraryController

class MusicLibraryView
  TITLE = "Santuri"

  USAGE = "\n\n\t\tUsage:\n" \
      "\tlist songs\t: List all songs.\n" \
      "\tlist artists\t: List all artists.\n" \
      "\tlist genres\t: List all genres.\n" \
      "\tplay song\t: Play a song.\n" \
      "\tlist artist\t: List the artist.\n" \
      "\tlist genre\t: List the genre.\n" \
      "\texit\t\t: Quit the program.\n" \
      "\thelp\t\t: View available commands.\n"

  def introduction
    font = Figlet::Font.new("./lib/fonts/univers.flf")
    figlet = Figlet::Typesetter.new(font)
    print figlet[TITLE]
    print USAGE
  end

  def list_songs(song, index)
    puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
  end

  def list_artists(artist, index)
    puts "#{index + 1}. #{artist.name}"
  end

  def list_genres(genre, index)
    puts "#{index + 1}. #{genre.name}"
  end

  def play_song(song = nil, song_available = false)
    if song && song_available
      puts "Playing #{song.artist.name} - #{song.name} - #{song.genre.name}"
    else
      puts "The song you requested does not exist. Enter " \
       "numbers 1 through #{Song.all.size}."
    end
  end

  def list_artist(song = nil, song_available = false)
    if song && song_available
      puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
    else
      puts "The artist you requested does not exist. Use command " \
        "'list artists' to view available artists."
    end
  end

  def list_genre(song, song_available = false)
    if song && song_available
     puts "#{song.artist.name} - #{song.name} - #{song.genre.name}"
    else
      "The genre you requested does not exist. Use command " \
        "'list genres' to view available artists."
    end
  end

  def help(invalid = false)
    puts "Invalid command.\n".colorize(:red) if invalid
    print USAGE
  end
end