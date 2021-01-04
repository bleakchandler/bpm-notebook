class Setlist < ActiveRecord::Base

    belongs_to :user
    has_many :performances
    has_many :songs, through: :performances

end
