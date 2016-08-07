describe FileParser do
  describe '#stub' do
    def add_text(file, text)
      File.open(file, 'w') { |f| f.puts text }
    end

    def stub_all
      RStub.new.start(['*', 'target'])
    end

    def expect_text(file, text)
      expect(IO.read("target/#{file}")).to eql(text)
    end

    describe 'can stub files in the top directory' do
      it 'can add text without stubs' do
        text = "foo\nbar\n"
        add_text('file1.rb', text)
        stub_all
        expect_text('file1.rb', "foo\nbar\n")
      end

      it 'stubs out stub delimiter' do
        text = "# STUB\n"
        add_text('file1.rb', text)
        stub_all
        expect_text('file1.rb', '')
      end

      it 'preserves text before stub delimiter' do
        text = "hello\n# STUB\n"
        add_text('file1.rb', text)
        stub_all
        expect_text('file1.rb', "hello\n")
      end

      it 'doesn\'t include endstub delimiter' do
        text = "# STUB\n# ENDSTUB\n"
        add_text('file1.rb', text)
        stub_all
        expect_text('file1.rb', '')
      end

      it 'doesn\'t include text between stub delimiters' do
        text = "# STUB\n hello # ENDSTUB\n"
        add_text('file1.rb', text)
        stub_all
        expect_text('file1.rb', '')
      end

      it 'doesn\'t include text after the # STUB' do
        text = "# STUB\n hello\n"
        add_text('file1.rb', text)
        stub_all
        expect_text('file1.rb', '')
      end

      it 'doesn\'t care about other stub starting delimiters after the first' do
        text = "# STUB\n hello\n # STUB"
        add_text('file1.rb', text)
        stub_all
        expect_text('file1.rb', '')
      end

      it 'includes plain end stub delimiters' do
        text = "# ENDSTUB\n"
        add_text('file1.rb', text)
        stub_all
        expect_text('file1.rb', "# ENDSTUB\n")
      end

      it 'resumes putting in text after end delimiter' do
        text = "hello\n# STUB\nworld\n# ENDSTUB\nfoo\n"
        add_text('file1.rb', text)
        stub_all
        expect_text('file1.rb', "hello\nfoo\n")
      end
    end

    describe 'can stub html files' do
      it 'can add text without stubs' do
        text = "foo\nbar\n"
        add_text('file1.html.erb', text)
        stub_all
        expect_text('file1.html.erb', "foo\nbar\n")
      end

      it 'doesn\'t include text between stub delimiters' do
        text = "<!-- STUB -->\n hello <!-- ENDSTUB -->\n"
        add_text('file1.html.erb', text)
        stub_all
        expect_text('file1.html.erb', '')
      end
    end
  end
end
