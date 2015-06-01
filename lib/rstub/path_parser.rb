class PathParser

  def get_globs(files)
    glob_files = check_globs(files)
    files.concat(glob_files).flatten.uniq
  end

  private

  def check_globs(files)
    has_glob = /\*/
    globs = files.select do |file|
      !(has_glob =~ file).nil?
    end
    find_matching_files(globs)
  end

  def find_matching_files(globs)
    Dir.glob('*')
  end

end

