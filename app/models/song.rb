class Song < ActiveRecord::Base
  has_many :setlists
  has_many :users, through: :setlists
  attr_reader :set_id, :spotify_id





end
