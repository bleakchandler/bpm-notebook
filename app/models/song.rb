class Song < ActiveRecord::Base
  
  has_many :performances
  has_many :setlists, through: :performances
  
  def spotify_features
    RSpotify::AudioFeatures.find( self.spotify_id )
  end

  def name
    RSpotify::Track.find( self.spotify_id ).name
  end

  def tempo
    self.spotify_features.tempo
  end

  def danceability
    self.spotify_features.danceability
  end

end
