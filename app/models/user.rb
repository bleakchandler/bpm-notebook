class User < ActiveRecord::Base
#has_many :sets
#has_many :songs through :sets
#Methods:
  ##username
  ##password
  ##update_username
  ##update_password
  ##new_Set
#  RSpotify.authenticate("193b198408134255a518e263e5506194", "06b7fd3055584073a81b631ef4e8c8e6")
  attr_reader :spotify_user
  def initialize(arguments)
    super(arguments)
    @spotify_user = RSpotify::User.find(self.spotify_username)
  end
end
