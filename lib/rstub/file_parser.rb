class FileParser
  def stub(target_file, file)
    File.open(file, 'r') do |readable_file|
      File.open(target_file, 'w') do |target|
        write_text(target, readable_file)
      end
    end
  end

  private

  def start_stubbing?(line, stubbing)
    return true if !!/#\s*stub\s*/i.match(line)
    stubbing
  end

  def end_stubbing?(line, stubbing)
    return false if !!/#\s*endstub\s*/i.match(line)
    stubbing
  end

  def write_text(target, readable_file)
    stubbing = false
    IO.foreach(readable_file) do |line|
      stubbing = start_stubbing?(line, stubbing)
      target.puts line unless stubbing
      stubbing = end_stubbing?(line, stubbing)
    end
  end
end
