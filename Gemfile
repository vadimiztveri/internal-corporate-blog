source 'https://rubygems.org'

gem 'rails', '4.0.2'

group :doc do
  gem 'sdoc', require: false
end

gem 'jquery-rails'
gem 'slim', '2.0.2'
gem 'sass-rails', '4.0.1'
gem 'csso-rails', '0.3.2'
gem 'autoprefixer-rails'
gem 'coffee-rails', '4.0.1'

gem 'awesome_print'
gem 'pry-rails', '0.3.2'

gem 'dump'
gem 'pg'

gem "authlogic", "~> 3.3.0"
gem 'six', '0.2.0'

gem 'rails-i18n', '~> 4.0.1'
gem 'russian'

gem 'will_paginate', '~> 3.0'
gem 'gravtastic'
gem 'exception_notification', '4.0.1'
gem "sanitize", "~> 2.1.0"

group :development do
  gem 'letter_opener', '~> 1.1.2'
  gem 'pry-rails', '0.3.2'

  gem 'quiet_assets', '1.0.2'

  gem "capistrano", "2.15.5"
  gem "capistrano_colors", "0.5.5", :require => false
  gem "capistrano-ext", "1.2.1", :require => false
  gem "capistrano-unicorn", "0.1.10", :require => false
  gem "rvm-capistrano", "1.4.3", :require => false
end

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem 'capybara'
end

group :production, :staging do
  gem 'unicorn', '4.8.0'
end