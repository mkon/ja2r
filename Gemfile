source 'https://rubygems.org'

# Declare your gem's dependencies in keys-oauth.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

group :development, :test do
  gem 'byebug'
  gem 'rspec', '~> 3.7'
  gem 'rubocop', '1.61.0'
  gem 'rubocop-rspec', '3.0.3'
  gem 'simplecov', '~> 0.16'
end

# Required for combination of old activesupport (< 7.1) and new ruby (> 3.3)
gem 'base64'
gem 'bigdecimal'

if (version = ENV['ACTIVESUPPORT'])
  gem 'activesupport', "~> #{version}.0"
end
