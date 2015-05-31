describe RStub do
  it 'creates the correct directory' do
    rstub = RStub.new
    rstub.start('foo.rb bar')
    expect(Dir.exist?('bar')).to be true
    Dir.rmdir('bar')
  end
end

