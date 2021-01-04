# Methods:
  # #username
  # #password
  # #update_username
  # #update_password
  # #new_setlist
  
  class User < ActiveRecord::Base

  has_many :setlists
  # has_many :songs through :setlists

  attr_reader :spotify_user
  attr_accessor :username, :password 
  
  def initialize(arguments)
    super(arguments)
    @spotify_user = RSpotify::User.find(self.spotify_username)
  end

  # set_arguments = { name: set_name, tempo: set_tempo }
  def new_setlist( setlist_arguments )
    Setlist.create( name: setlist_arguments[ :name ], tempo: setlist_arguments[ :tempo ], user_id: self.id )
  end

end
