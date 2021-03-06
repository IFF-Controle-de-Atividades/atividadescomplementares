source 'https://rubygems.org'

gem 'rails', '3.2.11'

gem "jquery-rails"
gem "mongoid", ">= 3.1.2"
gem "mongoid_auto_increment_id", ">=0.6.0"
gem "webrat"
gem "aws-sdk", "~> 1.3.4"

gem 'json'
gem 'bson_ext'
gem 'rack-raw-upload', '1.1.0'
gem 'carrierwave'
gem 'mini_magick'
gem "carrierwave-mongoid"

gem "devise", ">= 2.2.3"
gem 'will_paginate_mongoid'
gem 'actionmailer_inline_css'

# Deploy with Capistrano
gem "capistrano"

group :assets do
  gem "sass-rails",   "~> 3.2.3"
  gem "coffee-rails", "~> 3.2.1"
  gem "therubyracer", :platforms => :ruby
  gem "uglifier", ">= 1.0.3"
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem "rspec"
  gem "rspec-rails", ">= 2.12.2"
  gem "rb-fsevent"
  gem "autotest-standalone"
  gem "test_notifier"
  gem 'tlsmail'
  gem 'prawn'
  gem 'bcrypt-ruby', '~> 3.0.0'
end

group :test do
  gem "mongoid-rspec", ">= 1.7.0"
  gem "email_spec", ">= 1.4.0"
  gem "guard-rspec"
  gem "cucumber-rails", :require => false
  gem "factory_girl_rails", ">= 4.2.0"
  gem "capybara", ">= 2.0.3"
  gem "launchy", ">= 2.2.0"
  gem "database_cleaner", ">= 1.0.0.RC1"
end

group :development do
  gem "quiet_assets", ">= 1.0.2"
  gem "figaro", ">= 0.6.3"
  gem "better_errors", ">= 0.7.2"
  gem "binding_of_caller", ">= 0.7.1", :platforms => [:mri_19, :rbx] 
end