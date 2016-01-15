require 'bundler'
Bundler.setup

Bundler.require(:test, :development)
require 'fileutils'
Coveralls.wear!

require 'rstub'
Dir[File.expand_path('../../lib/rstub/*.rb', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.before :all do
    Dir.chdir('spec/fixtures')
    Dir.mkdir 'test_dir' unless Dir.exist? 'test_dir'
    File.new 'file1.rb', 'w+'
    File.new 'file2.rb', 'w+'
    File.new 'test_dir/nested_file.rb', 'w+'
  end

  config.after :each do
    FileUtils.rm_r 'target' if Dir.exist? 'target'
  end

  config.after :all do
    FileUtils.rm_r 'test_dir' if Dir.exist? 'test_dir'
    FileUtils.rm_r 'file1.rb'
    FileUtils.rm_r 'file2.rb'
    Dir.chdir('../..')
  end
end
