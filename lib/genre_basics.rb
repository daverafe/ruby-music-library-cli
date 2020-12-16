class Genre 
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
    def artists
        artists = self.songs.map {|song| song.artist}
        artists.uniq 
    end
end