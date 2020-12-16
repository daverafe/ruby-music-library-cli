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
        save 
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
end