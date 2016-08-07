describe PathParser do
  describe '#get_globs' do
    before :all do
      Dir.mkdir 'dir1/nested_dir'
      File.new 'dir1/nested_dir/nested_file2.rb', 'w+'
    end

    after :all do
      FileUtils.rm_r 'dir1/nested_dir' if Dir.exist? 'dir1/nested_dir'
    end

    let(:path_parser) { PathParser.new }

    it 'returns the same array when there is no match' do
      expect(path_parser.get_globs(['file1.rb'])[:files])
        .to match_array(['file1.rb'])
    end

    it 'returns glob matches from current directory' do
      paths = path_parser.get_globs(['*'])
      expect(paths[:directories])
        .to match_array(%w(dir1 nested_dir dir1/nested_dir))
      expect(paths[:files])
        .to match_array(%w(file1.rb file2.rb dir1/nested_file1.rb
                           dir1/nested_dir/nested_file2.rb))
    end

    it 'returns glob matches from lowel directory' do
      paths = path_parser.get_globs(['*/*'])
      expect(paths[:directories])
        .to match_array(%w(dir1 nested_dir dir1/nested_dir))
      expect(paths[:files])
        .to match_array(%w(dir1/nested_file1.rb
                           dir1/nested_dir/nested_file2.rb))
    end
  end
end
