require 'bundler'
Bundler.setup

Bundler.require(:test, :development)
require 'fileutils'
#Coveralls.wear!

require 'rstub'
Dir[File.expand_path('../../lib/rstub/*.rb', __FILE__)].each { |f| require f }
