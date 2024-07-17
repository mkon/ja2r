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
  gem 'rubocop', '1.65.0'
  gem 'rubocop-rspec', '2.25.0'
  gem 'simplecov', '~> 0.16'
end

if (version = ENV['ACTIVESUPPORT'])
  gem 'activesupport', "~> #{version}.0"
end
