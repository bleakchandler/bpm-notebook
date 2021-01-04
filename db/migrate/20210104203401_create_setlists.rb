class CreateSetlists < ActiveRecord::Migration[5.2]
  
  def change
    create_table :setlists do | t |
      t.string :name
      t.float :tempo
      t.integer :user_id
      t.timestamps
    end
  end

end
