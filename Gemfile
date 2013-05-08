source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.beta1'

#-------------------------------
# test
#-------------------------------
group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'spork'
  gem 'simplecov'
  gem 'rb-fsevent'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'libnotify' if /linux/ =~ RUBY_PLATFORM
  gem 'rb-inotify' if /linux/ =~ RUBY_PLATFORM
  gem 'growl' if /darwin/ =~ RUBY_PLATFORM
end

#-------------------------------
# Database
#-------------------------------
group :development do
  gem 'sqlite3'
end

group :production, :test do
  gem 'mysql2'
end

#-------------------------------
# Gems used only for assets and not required
# in production environments by default.
#-------------------------------
group :assets do
  gem 'sass-rails',   '~> 4.0.0.beta1'
  gem 'coffee-rails', '~> 4.0.0.beta1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.0.3'
end

#-------------------------------
# Basis
#-------------------------------
gem 'jquery-rails'
gem 'haml-rails'
gem 'bootstrap-sass', '~> 2.3.1.0'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', group: :development

# To use debugger
# gem 'debugger'

gem 'devise', github: 'plataformatec/devise', branch: 'rails4'
