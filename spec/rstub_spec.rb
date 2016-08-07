describe RStub do
  describe '#start' do
    let(:rstub) { RStub.new }

    it 'creates the correct directory and file' do
      rstub.start(['file1.rb', 'target'])
      expect(Dir.exist?('target')).to be true
      expect(File.exist?('target/file1.rb')).to be true
    end

    it 'raises error with invalid number of arguments' do
      expect { rstub.start }.to raise_error('Not enough arguments')
      expect { rstub.start(['file1']) }.to raise_error('Not enough arguments')
    end

    it 'raises error if the last argument isn\'t a directory' do
      expect { rstub.start(['file1.rb', 'file2.rb']) }
        .to raise_error('The last argument needs to be a directory')
      expect { rstub.start(['target', 'file1.rb']) }
        .to raise_error('The last argument needs to be a directory')
      expect { rstub.start(['file1.rb', '*']) }
        .to raise_error('The last argument needs to be a directory')
    end

    it 'doesn\'t create files that aren\' already there but were passed in' do
      rstub.start(['bar.rb', 'target'])
      expect(Dir.exist?('target')).to be true
      expect(File.exist?('target/bar.rb')).to be false
    end

    it 'adds multiple files to the directory' do
      rstub.start(['file1.rb', 'file2.rb', 'target'])
      expect(Dir.exist?('target')).to be true
      expect(File.exist?('target/file1.rb')).to be true
      expect(File.exist?('target/file2.rb')).to be true
    end

    it 'doesn\'t add nonexistent files even when there are multiple files' do
      rstub.start(['file1.rb', 'bar.rb', 'target'])
      expect(Dir.exist?('target')).to be true
      expect(File.exist?('target/file1.rb')).to be true
      expect(File.exist?('target/bar.rb')).to be false
    end

    it 'doesn\'t add nonexistent files even with wildcard' do
      rstub.start(['file1/*', 'target'])
      expect(Dir.exist?('target')).to be true
      expect(Dir.exist?('target/file1')).to be false
    end

    it 'all files are added with wildcard' do
      rstub.start(['*', 'target'])
      expect(Dir.exist?('target')).to be true
      expect(File.exist?('target/file1.rb')).to be true
      expect(File.exist?('target/file2.rb')).to be true
      expect(Dir.exist?('target/dir1')).to be true
      expect(File.exist?('target/dir1/nested_file1.rb')).to be true
    end
  end
end
