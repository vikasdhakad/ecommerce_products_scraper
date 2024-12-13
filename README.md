# README

This app is being tested on Ubuntu 22.04.3 LTS on my local system to scrape data from an eCommerce platform.

# System Requirements 

nodejs Version: 18

Ruby Version: 3.2.0

Rails: 7.1.2

Required on an Ubuntu system: Chromium WebDriver, which should match the version of Chrome/Chromium installed on your system.

# This App Run Requirements:

1. yarn install

2. rails javascript:install:esbuild 

3. gem install foreman

4. bundle exec gem install foreman

5. yarn add react react-dom
   yarn add axios

# Run Server, Run Rails + React

bin/dev


# This Rails app is created with React Default by using below commands

mkdir ecommerce_products_scraper
cd ecommerce_products_scraper

echo "ecommerce_products_scraper" > .ruby-gemset

echo "source 'https://rubygems.org'" > Gemfile

echo 'git_source(:github) { |repo| "https://github.com/#{repo}.git" }' >> Gemfile

echo "ruby '3.2.0'" >> Gemfile

echo "gem 'rails', '7.1.2'" >> Gemfile

cd ..

cd ecommerce_products_scraper

bundle install

bundle exec rails new . -j esbuild
