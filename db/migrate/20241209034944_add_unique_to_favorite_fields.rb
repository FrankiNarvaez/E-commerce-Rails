class AddUniqueToFavoriteFields < ActiveRecord::Migration[8.0]
  def change
    add_index :favorites, %i[ user_id product_id], unique: true
  end
end
