source 'https://ruby.taobao.org'

gem 'rails', '3.2.13'
gem 'bootstrap-sass'
gem 'bcrypt-ruby', '3.0.1'
gem 'bootstrap-will_paginate'
gem 'faker', '1.0.1'
gem "mail"

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'sqlite3', '1.3.5'
  gem 'rspec-rails', '2.11.0'
  gem 'guard-rspec' 
  gem 'guard'
  gem 'rspec'
  gem 'spork'
  gem 'annotate', '2.5.0'
  gem 'childprocess'
  gem 'guard-spork'
  #gem 'rb-inotify'

  gem 'libnotify' if /linux/ =~ RUBY_PLATFORM
  gem 'growl' if /darwin/ =~ RUBY_PLATFORM
  # Test gems on Macintosh OS X          
  gem 'rb-fsevent', :require => false
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.3'
  gem 'coffee-rails', '3.2.2'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '1.2.3'
end

gem 'jquery-rails'

group :test do
  gem 'capybara', '1.1.2'
  gem 'factory_girl_rails', '4.1.0'
end

group :production do
  gem 'pg', '0.12.2'
end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
