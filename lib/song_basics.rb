class Song
    @@all = []
    attr_accessor :name 
    attr_reader :artist, :genre
    def initialize(name, artist = nil, genre = nil)
        @name = name
        if artist == nil 
            @artist = artist
        else
            self.artist=(artist)
        end
        if genre == nil 
            @genre = genre
        else
            self.genre=(genre)
        end 
    end
    def save
        @@all << self
    end
    def self.all
        @@all
    end
    def self.create(name)
        song = self.new(name)
        song.save 
        song 
    end
    def self.destroy_all
        @@all.clear
    end
   def artist=(artist)
        @artist = artist 
        artist.add_song(self) unless artist.songs.include?(self)
   end
   def genre=(genre)
        @genre = genre
        self.genre = genre unless self.genre == genre    
        genre.songs << self unless genre.songs.include?(self)
    end
    def self.find_by_name(name) 
        self.all.find{|song| song.name == name}
    end
    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name) 
    end
    def self.new_from_filename(filename)
        file = filename.split(" - ")
        song_name = self.find_or_create_by_name(file[1]) 
        song_artist = Artist.find_or_create_by_name(file[0])
        song_genre = Genre.find_or_create_by_name(file[2].gsub(".mp3", ""))
        song = self.new(song_name.name, song_artist, song_genre)
        song  
    end
    def self.create_from_filename(filename)
        song = self.new_from_filename(filename)
        song.save
        song
    end
end