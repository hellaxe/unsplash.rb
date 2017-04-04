source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'bundler', '>= 1.8.4'
gem 'rails', '~> 5.0.1'
gem 'pg'
gem 'puma', '~> 3.0'
# gem 'sass-rails', '~> 5.0'
gem 'sassc-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'mini_magick'
gem 'carrierwave'
gem 'slim'
gem 'semantic-ui-sass', git: 'https://github.com/doabit/semantic-ui-sass.git'
gem 'kaminari'

source 'https://rails-assets.org' do
  gem 'rails-assets-underscore'
end

group :development, :test do

  gem 'byebug', platform: :mri
  gem 'pry'
end

group :development do

  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
