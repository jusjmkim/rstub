# FileParser goes through a file and writes the contents of it to a target file,
# but it ignores anything between the delimiters # STUB and # ENDSTUB.
class FileParser
  attr_accessor :stub_regex, :end_stub_regex, :stubbing

  def stub(target_file, file)
    set_delimiters(file)
    File.open(file, 'r') do |readable_file|
      File.open(target_file, 'w') do |target|
        write_text(target, readable_file)
      end
    end
  end

  private

  def start_stubbing?(line)
    self.stubbing = true if line.valid_encoding? && stub_regex.match(line.force_encoding('UTF-8'))
  end

  def end_stubbing?(line)
    self.stubbing = false if line.valid_encoding? && end_stub_regex.match(line.force_encoding('UTF-8'))
  end

  def write_text(target, readable_file)
    self.stubbing = false
    IO.foreach(readable_file) do |line|
      start_stubbing?(line)
      target.puts line unless stubbing
      end_stubbing?(line)
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
