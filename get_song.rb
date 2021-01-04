require 'pry'
require 'rspotify'

RSpotify.authenticate("193b198408134255a518e263e5506194", "06b7fd3055584073a81b631ef4e8c8e6")

thriller = RSpotify::Track.search('Thriller').first
thriller_features = RSpotify::AudioFeatures.find( thriller.id )

josh = RSpotify::User.find('2ig2t4utlvmi19fp9th7ogvck')
josh_tracks = josh.playlists.collect{ | playlist | playlist.tracks }.flatten

josh_tempos = josh_tracks.map{ | track | RSpotify::AudioFeatures.find( track.id ).tempo }

binding.pry
false