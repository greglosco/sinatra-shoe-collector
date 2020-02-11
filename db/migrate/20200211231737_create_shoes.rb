class CreateShoes < ActiveRecord::Migration
  def change
    create_table :shoes do |t|
      t.string :name 
      t.string :brand 
      t.string :color 
      t.integer :user_id
    end
  end
end
