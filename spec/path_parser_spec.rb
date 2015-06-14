describe PathParser do
  describe '#get_globs' do
    before(:all) do
      Dir.chdir('spec/fixtures')
      @path_parser = PathParser.new
    end

    it 'returns the same array when there is no match' do
      expect(@path_parser.get_globs(['foo.rb'])).to match_array(['foo.rb'])
    end

    it 'returns glob matches from current directory' do
      expect(@path_parser.get_globs(['*']))
        .to match_array(['baz.rb', 'foo.rb', 'foobar'])
    end

    it 'adds glob matches to the rest of the files' do
      expect(@path_parser.get_globs(['*', 'foo/bar.rb']))
        .to match_array(['foo/bar.rb', 'baz.rb', 'foo.rb', 'foobar'])
    end

    it 'returns glob matches from lowel directory' do
      expect(@path_parser.get_globs(['*/*']))
        .to match_array(['foobar/foobaz.rb'])
    end
  end
end
