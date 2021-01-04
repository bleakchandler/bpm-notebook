require 'pry'
require 'rspotify'

RSpotify.authenticate("193b198408134255a518e263e5506194", "06b7fd3055584073a81b631ef4e8c8e6")
thriller = RSpotify::Track.search('Thriller').first
thriller_features = RSpotify::AudioFeatures.find( thriller.id )

binding.pry
false