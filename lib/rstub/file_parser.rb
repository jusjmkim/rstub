# FileParser goes through a file and writes the contents of it to a target file,
# but it ignores anything between the delimiters # STUB and # ENDSTUB.
class FileParser
  attr_accessor :stub_regex, :end_stub_regex, :stubbing

  def stub(target_file, file)
    determine_delimiters(file)
    File.open(file, 'r') do |readable_file|
      File.open(target_file, 'w') do |target|
        write_text(target, readable_file)
      end
    end
  end

  private

  def start_stubbing?(line)
    self.stubbing = true if line.valid_encoding? && stub_regex.match(line)
  end

  def end_stubbing?(line)
    self.stubbing = false if line.valid_encoding? && end_stub_regex.match(line)
  end

  def write_text(target, readable_file)
    self.stubbing = false
    IO.foreach(readable_file) do |line|
      start_stubbing?(line)
      target.puts line unless stubbing
      end_stubbing?(line)
    end
  end

  def determine_delimiters(file)
    self.stub_regex, self.end_stub_regex = if /\w+\.html/i =~ file
                                             [/<!--\s+STUB\s+-->/i,
                                              /<!--\s+ENDSTUB\s+-->/i]
                                           else
                                             # defaults to Ruby delimiters
                                             [/#\s*stub\s*/i,
                                              /#\s*endstub\s*/i]
                                           end
  end
end
