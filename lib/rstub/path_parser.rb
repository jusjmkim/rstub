# PathParser parses directory and file paths into a hash with directory and file
# arrays.
class PathParser
  def get_globs(files)
    glob_files = check_globs(files)
    directories = get_directories(glob_files)
    all_files = get_files_from_directory(glob_files, directories)
    { directories: directories, files: all_files.flatten.uniq }
  end

  private

  def glob?(file)
    !/\*/.match(file).nil?
  end

  def check_globs(files)
    new_files = []
    files.each { |file| new_files << (glob?(file) ? Dir.glob(file) : file) }
    new_files.flatten
  end

  def in_directory?(file)
    !%r{\/}.match(file).nil?
  end

  def extract_directories(file)
    file.split('/').slice(0...-1)
  end

  def parse_out_directories(files)
    directories = []
    files.each do |file|
      directories << extract_directories(file) if in_directory?(file)
    end
    directories.flatten
  end

  def get_directories(files)
    dirs = []
    files.each do |file|
      if Dir.exist? file
        dirs << file
        dirs.concat(get_directories(Dir.glob("#{file}/*")))
      end
    end
    dirs
  end

  def get_files_from_directory(files, directories)
    directories.each do |dir|
      files.delete(dir)
      Dir.glob("#{dir}/*").each do |file|
        files << file unless File.directory? file
      end
    end
    files
  end
end
