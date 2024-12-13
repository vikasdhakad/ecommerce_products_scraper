require 'nokogiri'
require 'httparty'

class ScrapingService
  def initialize(url)
    @url = url
  end

  def scrape
    Selenium::WebDriver::Chrome::Service.driver_path = '/usr/bin/chromedriver'
    options = Selenium::WebDriver::Chrome::Options.new
    options.binary = '/usr/bin/chromium-browser'
    driver = Selenium::WebDriver.for :chrome, options: options
    driver.navigate.to @url.squish

    wait = Selenium::WebDriver::Wait.new(timeout: 10)

    wait.until { driver.find_element(:css, '.C7fEHH h1._6EBuvT span.VU-ZEz').displayed? }

    title = driver.find_element(:css, '.C7fEHH h1._6EBuvT span.VU-ZEz').text.squish

    driver.find_element(:css, '.Cnl9Jt').click
    begin
      wait.until { driver.find_element(:css, '.Cnl9Jt button.QqFHMw.n4gy8q').displayed? }
      driver.find_element(:css, '.Cnl9Jt button.QqFHMw.n4gy8q').click    
    rescue StandardError => e
      
    end
    description = driver.find_element(:css, '.Cnl9Jt').text

    price = driver.find_element(:css, '.dB67CR .hl05eU .Nx9bqj.CxhGGd').text.gsub('₹', '').to_f
    size = driver.find_element(:css, '.cPHDOP .OYP50x .hSEbzK li a').text
    category = driver.find_elements(:css, '.r2CdBx .R0cyWM').map(&:text)[1] || 'N/A'
    contact_info = driver.find_element(:css, '#sellerName span span').text
    image_url = driver.find_element(:css, 'img.utBuJY').attribute('src')

    driver.close()

    { title: title, description: description, price: price, size: size,
      category: category, contact_info: contact_info, url: @url,
      image_url: image_url }
  end
end
