class AddDetailsToRests < ActiveRecord::Migration[5.1]
  def change
    add_column :rests, :station, :string
    add_column :rests, :walk, :integer
    add_column :rests, :shop_image1, :string
    add_column :rests, :shop_image2, :string
    add_column :rests, :address, :string
    add_column :rests, :tel, :string
    add_column :rests, :opentime, :string
  end
end
