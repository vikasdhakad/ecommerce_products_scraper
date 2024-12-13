class Product < ApplicationRecord
  belongs_to :category

  validates :title, :description, :price, :category, :image_url, :url, presence: true

  def self.create_from_scrape(scraped_data)
    category = Category.find_or_create_by(name: scraped_data[:category])
    product = Product.create(
      title: scraped_data[:title],
      description: scraped_data[:description],
      price: scraped_data[:price],
      size: scraped_data[:size],
      contact_info: scraped_data[:contact_info],
      category: category,
      image_url: scraped_data[:image_url],
      last_scraped_at: Time.zone.now,
      url: scraped_data[:url]
    )
    product
  end

  def update_refetch_data(scraped_data)
    update(
      title: scraped_data[:title],
      description: scraped_data[:description],
      price: scraped_data[:price],
      size: scraped_data[:size],
      contact_info: scraped_data[:contact_info],
      image_url: scraped_data[:image_url],
      last_scraped_at: Time.zone.now
    )
  end
end
