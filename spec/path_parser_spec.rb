describe PathParser do
  describe '#get_globs' do
    let(:path_parser) { PathParser.new }

    it 'returns the same array when there is no match' do
      expect(path_parser.get_globs(['file1.rb'])[:files])
        .to match_array(['file1.rb'])
    end

    it 'returns glob matches from current directory' do
      expect(path_parser.get_globs(['*']))
        .to match_array(directories: ['test_dir'],
                        files: %w(file1.rb file2.rb test_dir/nested_file.rb))
    end

    it 'adds glob matches to the rest of the files' do
      expect(path_parser.get_globs(['*', 'file1/bar.rb'])[:directories])
        .to match_array(%w(file1 test_dir))
      expect(path_parser.get_globs(['*', 'file1/bar.rb'])[:files])
        .to match_array(%w(file1/bar.rb file2.rb file1.rb test_dir/nested_file.rb))
    end

    it 'returns glob matches from lowel directory' do
      expect(path_parser.get_globs(['*/*']))
        .to match_array(directories: ['test_dir'],
                        files: ['test_dir/nested_file.rb'])
    end
  end
end
