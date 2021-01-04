class Performance < ActiveRecord::Base

    belongs_to :setlist
    belongs_to :song

end
