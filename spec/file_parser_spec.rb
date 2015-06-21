describe FileParser do
  describe '#stub' do
    before(:all) do
      Dir.chdir('spec/fixtures')
    end

    before(:each) do
      RStub.new.start('* target')
    end

    after(:each) do
      FileUtils.rm_r('target')
    end

    after(:all) do
      Dir.chdir('../..')
    end

    it 'can add text without stubs' do
      expect(IO.read('target/foo.rb')).to eql("foo\n")
    end

  end
end
