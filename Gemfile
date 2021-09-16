source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'dotenv-rails', require: 'dotenv/rails-now'

gem 'rails', '~> 6.1.4'
gem 'puma', '~> 5.0'
gem 'webpacker', '~> 5.4'
gem 'pg', '~> 1.2.3'

gem 'devise'
gem 'ransack'
gem 'pagy', '~> 3.5'

gem 'hiredis'
gem 'redis', '>= 4.0', require: ['redis', 'redis/connection/hiredis']
gem 'sidekiq'

gem 'cable_ready', '5.0.0.pre3'

gem 'haml-rails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'faker'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
end
