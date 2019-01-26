$LOAD_PATH.push File.expand_path('lib', __dir__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ja2r'
  s.version     = ENV.fetch 'VERSION', '0.3.0'
  s.authors     = ['mkon']
  s.email       = ['konstantin@munteanu.de']
  s.homepage    = 'https://github.com/mkon/ja2r'
  s.summary     = 'Simple JSON-API to ruby object conversion'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'README.md']

  s.add_dependency 'activesupport', '>= 4.2', '< 6'

  s.add_development_dependency 'rspec', '~> 3.7'
  s.add_development_dependency 'rubocop', '0.63.1'
  s.add_development_dependency 'rubocop-rspec', '1.31.0'
  s.add_development_dependency 'simplecov', '~> 0.16'
end
