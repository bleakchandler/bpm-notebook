class Setlist < ActiveRecord::Base

    belongs_to :user
    belongs_to :songs

    attr_reader :name, :tempo, :user_id

end
