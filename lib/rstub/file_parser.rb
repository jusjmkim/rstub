class FileParser
  def stub(target_file, file)
    target = File.open(target_file, 'w')
    readable_file = File.open(file, 'r')
    IO.foreach(readable_file) { |line| IO.write(target, line) }
  end
end
