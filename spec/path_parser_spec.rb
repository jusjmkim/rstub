describe PathParser do
  describe '#check_globs' do
    before do
      @path_parser = PathParser.new
    end

    it 'returns the same array when there is no match' do
      expect(@path_parser.check_globs(['foo.rb'])).to eq(['foo.rb'])
    end

    it '' do

    end
  end
end
