require 'rstub/file_parser'
require 'rstub/path_parser'

# RStub takes command line arguments, calls PathParser to parse them, creates
# new files according to those arguments, and calls FileParser to parse those
# files and write them to the newly generated files.
class RStub
  attr_reader :file_parser, :path_parser
  attr_accessor :target, :files, :directories, :target_files

  def initialize
    @file_parser = FileParser.new
    @path_parser = PathParser.new
  end

  def start(args = [])
    raise ArgumentError, 'Not enough arguments' if args.size < 2
    parse_args(args)
    make_new_directory_structure
    parse_files
  end

  private

  def directory?(directory)
    directory != '*' && /\.\w+$/.match(directory).nil?
  end

  # returns a hash with a files key with a value of an array of the files to be
  # stubbed and a directory key with the name of the directory to be made as a
  # string
  def parse_args(args)
    self.target = args.pop
    unless directory?(target)
      raise ArgumentError, 'The last argument needs to be a directory'
    end
    self.files = args
  end

  def make_target_directory
    Dir.mkdir(target) unless Dir.exist? target
  end

  def make_new_directories
    directories.each do |d|
      new_dir = "#{target}/#{d}"
      Dir.mkdir(new_dir) unless Dir.exist?(new_dir)
    end
  end

  def make_new_files
    target_files.each { |file| File.new(file, 'w') unless directory? file }
  end

  def parse_files_and_directories
    parsed_path = path_parser.get_globs(files)
    self.files = parsed_path[:files].select { |file| File.exist? file }
    self.target_files = files.map { |file| "#{target}/#{file}" }
    self.directories = parsed_path[:directories]
  end

  def make_new_directory_structure
    make_target_directory
    parse_files_and_directories
    make_new_directories
    make_new_files
  end

  def parse_files
    target_files.each.with_index do |target_file, i|
      file_parser.stub(target_file, files[i])
    end
  end
end
