class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.float :price
      t.string :contact_info
      t.string :size
      t.references :category, null: false, foreign_key: true
      t.string :url
      t.string :image_url
      t.datetime :last_scraped_at

      t.timestamps
    end
  end
end
