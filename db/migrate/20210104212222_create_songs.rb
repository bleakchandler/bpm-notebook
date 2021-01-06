class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.string :spotify_id
      t.string :name
      t.string :artist
      t.integer :released
      t.float :tempo
      t.float :danceability
      t.float :energy
      t.float :valence
      t.float :loudness
      t.timestamps
    end
  end
end
