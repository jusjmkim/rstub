class RStub
  attr_reader :file_parser, :path_parser

  def initialize
    @file_parser = FileParser.new
    @path_parser = PathParser.new
  end

  def start(raw_args = '')
    args = raw_args.split(' ')
    check_args(args)
  end

  private

  # returns a hash with a files key with a value of an array of the files to be
  # stubbed and a directory key with the name of the directory to be made as a
  # string
  def parse_arguments(args)
    args_hash = {}
    args_hash[:directory] = args.pop
    args_hash[:files] = args
    args_hash
  end

  def make_new_directory(directory)
    Dir.mkdir(directory)
  end

  def make_new_files(files)
    files.each do |file|
      File.new(file)
    end
  end

  def make_new_directory_structure(args_hash)
    make_new_directory(args_hash[:directory])
    checked_files = path_parser.get_globs(args_hash[:files])
    make_new_files(checked_files)
  end

  def check_args(args)
    if args.size < 2
      puts 'Not enough arguments'
    else
      make_new_directory_structure(parse_arguments(args))
    end
  end
end
