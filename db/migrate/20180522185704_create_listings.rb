class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :title_text
      t.decimal :price
      t.string :housing
      t.text :body
      t.date :available_date
      t.string :available_message
      t.text :listing_attributes
      t.string :street_address
      t.text :google_map_url
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
