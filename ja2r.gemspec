$LOAD_PATH.push File.expand_path('lib', __dir__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ja2r'
  s.version     = ENV.fetch 'VERSION', '0.7.0'
  s.authors     = ['mkon']
  s.email       = ['konstantin@munteanu.de']
  s.homepage    = 'https://github.com/mkon/ja2r'
  s.summary     = 'Simple JSON-API to ruby object conversion'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 3.2', '< 4.1'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'README.md']

  s.add_dependency 'activesupport', '>= 7.1', '< 8.2'

  s.metadata['rubygems_mfa_required'] = 'true'
end
