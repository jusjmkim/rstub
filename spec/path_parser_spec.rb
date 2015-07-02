describe PathParser do
  before(:all) do
    Dir.chdir('spec/fixtures')
  end

  after(:all) do
    Dir.chdir('../..')
  end

  describe '::directory?' do
    it 'no file extension is directory' do
      expect(PathParser.directory?('bar')).to be true
    end

    it 'file extension is file' do
      expect(PathParser.directory?('foo.rb')).to be false
    end

    it 'detects hidden directories' do
      expect(PathParser.directory?('.bar')).to be true
    end
  end

  describe '#get_globs' do
    let(:path_parser) { PathParser.new }

    it 'returns the same array when there is no match' do
      expect(path_parser.get_globs(['foo.rb'])[:files])
        .to match_array(['foo.rb'])
    end

    it 'returns glob matches from current directory' do
      expect(path_parser.get_globs(['*']))
        .to match_array(directories: ['foobar'],
                        files: %w(baz.rb foo.rb foobar/foobaz.rb))
    end

    it 'adds glob matches to the rest of the files' do
      expect(path_parser.get_globs(['*', 'foo/bar.rb'])[:directories])
        .to match_array(%w(foo foobar))
      expect(path_parser.get_globs(['*', 'foo/bar.rb'])[:files])
        .to match_array(%w(foo/bar.rb baz.rb foo.rb foobar/foobaz.rb))
    end

    it 'returns glob matches from lowel directory' do
      expect(path_parser.get_globs(['*/*']))
        .to match_array(directories: ['foobar'],
                        files: ['foobar/foobaz.rb'])
    end
  end
end
