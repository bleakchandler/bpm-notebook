# Methods:
  # #username
  # #password
  # #update_username
  # #update_password
  # #new_setlist

class User < ActiveRecord::Base

  has_many :setlists

  def spotify_user
    RSpotify::User.find( self.spotify_username )
  end

  # set_arguments = { name: set_name, tempo: set_tempo }
  def create_setlist( setlist_arguments )
    Setlist.create( name: setlist_arguments[ :name ], tempo: setlist_arguments[ :tempo ], user_id: self.id )
  end

  def remove_setlist( name )
    return nil if Setlist.find_by(name: name).nil?
    Setlist.find_by(name: name).destroy
  end

  def clear_setlist( name )
    return nil if Setlist.find_by(name: name).nil?
    Setlist.find_by(name: name).clear
  end
  
  def all_spotify_playlists
    self.spotify_user.playlists
  end

  def all_spotify_songs
    all_spotify_playlists.collect{ | playlist | playlist.tracks }.flatten
  end

  def all_spotify_ids
    all_spotify_songs.collect( &:id )
  end

  def songs_to_choose_from
    all_spotify_ids.map{ | id | Song.create( spotify_id: id ) }
  end

end
