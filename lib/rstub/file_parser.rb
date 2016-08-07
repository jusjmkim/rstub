# FileParser goes through a file and writes the contents of it to a target file,
# but it ignores anything between the delimiters # STUB and # ENDSTUB.
class FileParser
  attr_accessor :stub_regex, :end_stub_regex

  def stub(target_file, file)
    set_delimiters(file)
    File.open(file, 'r') do |readable_file|
      File.open(target_file, 'w') do |target|
        write_text(target, readable_file)
      end
    end
  end

  private

  def start_stubbing?(line, stubbing)
    return true if stub_regex.match(line)
    stubbing
  end

  def end_stubbing?(line, stubbing)
    return false if end_stub_regex.match(line)
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

  def set_delimiters(file)
    self.stub_regex, self.end_stub_regex = if /\w+\.rb/i.match(file)
                                             [/#\s*stub\s*/i, /#\s*endstub\s*/i]
                                           elsif /\w+\.html/i.match(file)
                                             [/<!--\s+STUB\s+-->/i, /<!--\s+ENDSTUB\s+-->/i]
                                           else
                                             # will never be matched by anything, thereby preserving all text
                                             [/$a/i, /$a/i]
                                           end
  end
end
