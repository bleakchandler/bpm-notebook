class Song < ActiveRecord::Base
  
  has_many :performances
  has_many :setlists, through: :performances

  attr_reader :info, :features

  def initialize( arguments )
    super( arguments )
    @info =     RSpotify::Track.find( self.spotify_id )
    @features = RSpotify::AudioFeatures.find( self.spotify_id )
  end

  def name
    self.info.name
  end

  def artist
    self.info.artists.first.name
  end

  def released
    self.info.album.release_date.split( "-" ).first
  end

  def to_s
    "#{ self.name } - #{ self.artist } (#{ self.released })"
  end

  def tempo
    self.features.tempo
  end

  def danceability
    self.features.danceability
  end

end
