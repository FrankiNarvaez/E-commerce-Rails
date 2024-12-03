class ChangeStringToTextAtDescriptionOfProduct < ActiveRecord::Migration[8.0]
  def change
    change_column(:products, :description, :text)
  end
end
