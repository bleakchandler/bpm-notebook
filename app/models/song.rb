class Song < ActiveRecord::Base

  has_many :performances
  has_many :setlists, through: :performances

  attr_accessor :info, :features

  def initialize( arguments )
    super( arguments )
    self.info = RSpotify::Track.find( self.spotify_id )
    self.features = RSpotify::AudioFeatures.find( self.spotify_id )
    self.name = self.info.name
    self.artist = self.info.artists.first.name
    self.released = self.info.album.release_date.split( "-" ).first.to_i
    self.tempo = self.features.tempo
    self.danceability = self.features.danceability
    self.energy = self.features.energy
    self.valence = self.features.valence
    self.loudness = self.features.loudness
    self.save
  end

  def to_s
    "#{ self.name } - #{ self.artist } (#{ self.released })"
  end

end

# Song.update( self.id, 
# :name => self.info.name,
# :artist => self.info.artists.first.name,
# :released => self.info.album.release_date.split( "-" ).first.to_i,
# :tempo => self.features.tempo,
# :danceability => self.features.danceability,
# :energy => self.features.energy,
# :valence => self.features.valence,
# :loudness => self.features.loudness,
# )