class ProductsController < ApplicationController
  def dashboard
    
  end

  def create
    url = params[:url]
    scraped_data = ScrapingService.new(url).scrape
    product = Product.create_from_scrape(scraped_data)

    render json: product, status: :created
  end

  def index
    products = Product
    if params[:search].present?
      @products = products.where("title LIKE ?", "%#{params[:search]}%").includes(:category)
    else
      @products = products.includes(:category).all
    end
         
    render json: @products.order(id: :desc), include: :category
  end

  def update
    @product = Product.find(params[:id])
    scraped_data = ScrapingService.new(@product.url).scrape
    @product.update(scraped_data)
    render json: @product
  end

  def refetch
    @product = Product.find(params[:id])
    scraped_data = ScrapingService.new(@product.url).scrape
    @product.update_refetch_data(scraped_data)
    render json: @product
  end
end
