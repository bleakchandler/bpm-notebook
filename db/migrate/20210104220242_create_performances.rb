class CreatePerformances < ActiveRecord::Migration[5.2]
  
  def change
    create_table :performances do | t |
      t.integer :setlist_id
      t.integer :song_id
      t.timestamps
    end
  end

end
