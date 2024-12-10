class CreateShoppingCarts < ActiveRecord::Migration[8.0]
  def change
    create_table :shopping_carts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
