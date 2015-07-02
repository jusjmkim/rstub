describe RStub do
  describe '#start' do
    before(:all) do
      Dir.chdir('spec/fixtures')
    end

    after(:each) do
      FileUtils.rm_r 'target' if Dir.exist?('target')
    end

    after(:all) do
      Dir.chdir('../..')
    end

    let(:rstub) { RStub.new }

    it 'creates the correct directory and file' do
      rstub.start(['foo.rb', 'target'])
      expect(Dir.exist?('target')).to be true
      expect(File.exist?('target/foo.rb')).to be true
    end

    it 'raises error with invalid number of arguments' do
      expect { rstub.start }.to raise_error('Not enough arguments')
      expect { rstub.start(['foo']) }.to raise_error('Not enough arguments')
    end

    it 'raises error if the last argument isn\'t a directory' do
      expect { rstub.start(['foo.rb', 'baz.rb']) }
        .to raise_error('The last argument needs to be a directory')
      expect { rstub.start(['target', 'foo.rb']) }
        .to raise_error('The last argument needs to be a directory')
      expect { rstub.start(['foo.rb', '*']) }
        .to raise_error('The last argument needs to be a directory')
    end

    it 'doesn\'t create files that aren\' already there but were passed in' do
      rstub.start(['bar.rb', 'target'])
      expect(Dir.exist?('target')).to be true
      expect(File.exist?('target/bar.rb')).to be false
    end

    it 'adds multiple files to the directory' do
      rstub.start(['foo.rb', 'baz.rb', 'target'])
      expect(Dir.exist?('target')).to be true
      expect(File.exist?('target/foo.rb')).to be true
      expect(File.exist?('target/baz.rb')).to be true
    end

    it 'doesn\'t add nonexistent files even when there are multiple files' do
      rstub.start(['foo.rb', 'bar.rb', 'target'])
      expect(Dir.exist?('target')).to be true
      expect(File.exist?('target/foo.rb')).to be true
      expect(File.exist?('target/bar.rb')).to be false
    end

    it 'doesn\'t add nonexistent files even with wildcard' do
      rstub.start(['foo/*', 'target'])
      expect(Dir.exist?('target')).to be true
      expect(Dir.exist?('target/foo')).to be false
    end

    it 'all files are added with wildcard' do
      rstub.start(['*', 'target'])
      expect(Dir.exist?('target')).to be true
      expect(File.exist?('target/foo.rb')).to be true
      expect(File.exist?('target/baz.rb')).to be true
      expect(Dir.exist?('target/foobar')).to be true
      expect(File.exist?('target/foobar/foobaz.rb')).to be true
    end
  end
end
