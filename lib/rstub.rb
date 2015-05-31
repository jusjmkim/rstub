class RStub
  attr_reader :parser

  def initialize
    @parser = Parser.new
  end

  def start(raw_args)
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

  def make_new_files(args_hash)
    Dir.mkdir("./#{args_hash[:directory]}")
  end

  def check_args(args)
    if args.size < 2
      puts 'Not enough arguments'
    else
      make_new_files(parse_arguments(args))
    end
  end

end

