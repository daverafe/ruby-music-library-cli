class Artist
    @@all = []
    attr_accessor :name, :songs 
    def initialize(name)
        @name = name
        @songs = []
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
    def add_song(song)
        @songs << song unless self.songs.include?(song)
        song.artist = self unless song.artist == self 
    end
    def genres
        genres = self.songs.map {|song| song.genre}
        genres.uniq 
    end
end