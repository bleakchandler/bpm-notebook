class Setlist < ActiveRecord::Base

    belongs_to :user
    has_many :performances
    has_many :songs, through: :performances

    def add_song(song)
      Performance.create(setlist_id: self.id, song_id: song.id)
    end

    def remove_song(song)
      Performance.destroy(Performance.find_by(setlist_id: self.id, song_id: song.id).id)
    end

    def clear
      Performance.where(setlist_id: self.id).destroy_all
    end

    def has_song_by_spotify_id?( song_spotify_id )
      return false if song_spotify_id.length < 22
      Performance.where( setlist_id: self.id, song_id: Song.find_by( spotify_id: song_spotify_id ).id ).empty?
    end

    # User.find( self.user_id ).songs_to_choose_from
end
