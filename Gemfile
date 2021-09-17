source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'dotenv-rails', require: 'dotenv/rails-now'

gem 'rails', '~> 6.1.4'
gem 'puma', '~> 5.0'
gem 'webpacker', '~> 5.4'
gem 'pg', '~> 1.2.3'

# gem 'devise'
gem "devise", github: "ghiculescu/devise", branch: "error-code-422" # https://github.com/heartcombo/devise/pull/5340 not yet merged
gem "responders", github: "heartcombo/responders" # https://github.com/heartcombo/responders/pull/223 not yet released

gem 'ransack'
gem 'pagy', '~> 3.5'

gem 'hiredis'
gem 'redis', '>= 4.0', require: ['redis', 'redis/connection/hiredis']
gem 'sidekiq'

gem 'stimulus_reflex', '~> 3.5.0.pre2'
gem 'cable_ready', '5.0.0.pre2'

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
