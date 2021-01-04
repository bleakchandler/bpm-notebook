class Setlist < ActiveRecord::Base

    belongs_to :user

    attr_reader :name, :tempo, :user_id 

end