class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.integer :setlist_id
      t.string :spotify_id
      t.timestamps
    end
  end
end
