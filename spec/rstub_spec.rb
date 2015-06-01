describe RStub do
  describe '#start' do
    before do
      $stdout = StringIO.new
      @rstub = RStub.new
    end

    after(:all) do
      $stdout = STDOUT
      Dir.rmdir('bar')
    end

    it 'creates the correct directory' do
      @rstub.start('foo.rb bar')
      expect(Dir.exist?('bar')).to be true
      Dir.rmdir('bar')
    end

    it 'creates the correct file' do
      @rstub.start('foo.rb bar')
      expect(File.exist?('bar/foo.rb')).to be true
      File.delete('bar/foo.rb') if File.exist?('bar/foo.rb')
      Dir.rmdir('bar')
    end

    it 'prints error with invalid number of arguments' do
      @rstub.start
      expect($stdout.string).to include('Not enough arguments')
      $stdout = StringIO.new
      @rstub.start('foo')
      expect($stdout.string).to include('Not enough arguments')
    end
  end
end

