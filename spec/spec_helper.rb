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
    Dir.glob('*').each { |f| FileUtils.rm_r f }
    Dir.mkdir 'dir1' unless Dir.exist? 'dir1'
    File.new 'file1.rb', 'w+'
    File.new 'file2.rb', 'w+'
    File.new 'dir1/nested_file1.rb', 'w+'
  end

  config.after :each do
    FileUtils.rm_r 'target' if Dir.exist? 'target'
  end

  config.after :all do
    FileUtils.rm_r 'dir1' if Dir.exist? 'dir1'
    FileUtils.rm_r 'file1.rb'
    FileUtils.rm_r 'file2.rb'
    Dir.chdir('../..')
  end
end
