class MusicLibraryController
    def initialize(path = './db/mp3s')
        @path = path
        file = MusicImporter.new(@path)
        file.import 
    end
    def call
        input = " "
        while input != "exit"
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?" 
            input = gets.strip 
            if input == "list songs"
                list_songs 
            elsif input == "list artists"
                list_artists
            elsif input == "list genres"
                list_genres
            elsif input == "list artist"
                list_songs_by_artist
            elsif input == "list genre"
                list_songs_by_genre
            elsif input == "play song"
                play_song
            elsif input == "exit"
                false   
            end       
        end
    end

    def list_songs
        song_names = Song.all.sort{ |a, b| a.name <=> b.name } 
        song_names.each_with_index {|song, i| puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
    end
    def list_artists
        artists = Artist.all.map {|artist| artist.name}
        artists.sort.each_with_index {|artist_name, i| puts "#{i + 1}. #{artist_name}"}
    end
    def list_genres
        genres = Genre.all.map {|genre| genre.name}
        genres.sort.each_with_index {|genre_name, i| puts "#{i + 1}. #{genre_name}"}
    end
    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip
        chosen_artist = Artist.find_by_name(input)
        if chosen_artist != nil
            chosen_songs = chosen_artist.songs 
            sorted_songs = chosen_songs.sort{ |a, b| a.name <=> b.name } 
            sorted_songs.each_with_index {|song, i| puts "#{i + 1}. #{song.name} - #{song.genre.name}"}
        end
    end
    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip
        chosen_genre = Genre.find_by_name(input)
        if chosen_genre != nil
            chosen_songs = chosen_genre.songs 
            sorted_songs = chosen_songs.sort{ |a, b| a.name <=> b.name } 
            sorted_songs.each_with_index {|song, i| puts "#{i + 1}. #{song.artist.name} - #{song.name}"}
        end
    end
    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip.to_i
        if (1..Song.all.length).include?(input)
          song = Song.all.sort{ |a, b| a.name <=> b.name }[input - 1]
        end
        puts "Playing #{song.name} by #{song.artist.name}" if song
      end
    
   
end 