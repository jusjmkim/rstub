Gem::Specification.new do |s|
  s.name = 'rstub'
  s.version = '0.3.2'

  s.date = '2016-08-07'
  s.summary = 'A gem to stub out code'
  s.description = 'A gem to stub out pieces of code'
  s.authors = 'Justin Kim'
  s.email = ['justinjmkim@gmail.com']
  s.executables = 'rstub'
  s.homepage = 'https://github.com/jusjmkim/rstub'
  s.license = 'MIT'

  s.add_development_dependency 'bundler', ['~> 1.8']
  s.add_development_dependency 'rake', ['~> 10.4']
  s.files = `git ls-files`.split($ORS)
  s.test_files = s.files.grep(/^spec/)
end
