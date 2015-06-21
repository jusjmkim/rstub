describe FileParser do
  describe '#stub' do
    before(:all) do
      Dir.chdir('spec/fixtures')
    end

    after(:each) do
      FileUtils.rm_r('target')
    end

    after(:all) do
      File.new('foo.rb', 'w')
      Dir.chdir('../..')
    end

    def add_text(text)
      File.open('foo.rb', 'w') { |f| f.puts text}
    end

    def stub_all
      RStub.new.start('* target')
    end

    def expect_text(text)
      expect(IO.read('target/foo.rb')).to eql(text)
    end

    it 'can add text without stubs' do
      text = "foo\nbar\n"
      add_text(text)
      stub_all
      expect_text("foo\nbar\n")
    end

    it 'stubs out stub delimiter' do
      text = "# STUB\n"
      add_text(text)
      stub_all
      expect_text('')
    end

    it 'preserves text before stub delimiter' do
      text = "hello\n# STUB\n"
      add_text(text)
      stub_all
      expect_text("hello\n")
    end

    it 'doesn\'t include endstub delimiter' do
      text = "# STUB\n# ENDSTUB\n"
      add_text(text)
      stub_all
      expect_text('')
    end

    it 'doesn\'t include text between stub delimiters' do
      text = "# STUB\n hello # ENDSTUB\n"
      add_text(text)
      stub_all
      expect_text('')
    end

    it 'doesn\'t include text after the # STUB' do
      text = "# STUB\n hello\n"
      add_text(text)
      stub_all
      expect_text('')
    end

    it 'doesn\'t care about other stub starting delimiters after the first' do
      text = "# STUB\n hello\n # STUB"
      add_text(text)
      stub_all
      expect_text('')
    end

    it 'includes plain end stub delimiters' do
      text = "# ENDSTUB\n"
      add_text(text)
      stub_all
      expect_text("# ENDSTUB\n")
    end

    it 'resumes putting in text after end delimiter' do
      text = "hello\n# STUB\nworld\n# ENDSTUB\nfoo\n"
      add_text(text)
      stub_all
      expect_text("hello\nfoo\n")
    end
  end
end
