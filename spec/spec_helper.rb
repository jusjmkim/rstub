require 'bundler'
Bundler.setup

require 'rstub'
Dir[File.expand_path('../../lib/rstub/*.rb', __FILE__)].each { |f| require f }

Bundler.require(:test)

