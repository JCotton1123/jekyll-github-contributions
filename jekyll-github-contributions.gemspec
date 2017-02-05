Gem::Specification.new do |s|
  s.name        = 'jekyll-github-contributions'
  s.version     = '0.1.1'
  s.summary     = 'Jekyll generator plugin that generates a Github contributions data file'
  s.description = File.read('README.md')
  s.license     = 'Apache 2'
  s.authors     = ['Jesse Cotton']
  s.email       = 'jcotton1123@gmail.com'
  s.files       = [*Dir['lib/**/*.rb'], 'README.md', 'LICENSE']
  s.homepage    = 'https://github.com/jcotton1123/jekyll-github-contributions'

  s.add_runtime_dependency 'jekyll', '~> 3.0'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rubocop'
end
