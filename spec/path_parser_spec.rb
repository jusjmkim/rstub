describe PathParser do
  describe '#get_globs' do
    before(:all) do
      Dir.chdir('spec/fixtures')
      @path_parser = PathParser.new
    end

    it 'returns the same array when there is no match' do
      expect(@path_parser.get_globs(['foo.rb'])).to eq(['foo.rb'])
    end

    it 'returns glob matches from current directory' do
      expect(@path_parser.get_globs(['*'])).to eq(['baz.rb', 'foo.rb', 'foobar'])
    end

    it 'adds glob matches to the rest of the files' do
      expect(@path_parser.get_globs(['*', 'foo/bar.rb']))
        .to eq(['foo/bar.rb', 'baz.rb', 'foo.rb', 'foobar'])
    end

    it 'returns glob matches from lowel directory' do
      expect(@path_parser.get_globs(['*/*'])).to eq(['foobar/foobaz.rb'])
    end

#    it 'prints warning if file is not found' do

    #end
  end
end

