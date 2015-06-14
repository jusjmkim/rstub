class PathParser
  def get_globs(files)
    glob_files = check_globs(files)
    files.concat(glob_files).flatten.uniq
  end

  private

  def check_globs(files)
    has_glob = /\*/
    globs = []
    files.each do |file|
      if has_glob =~ file
        globs << file
        files.delete(file)
      end
    end
    find_matching_files(globs)
  end

  def find_matching_files(globs)
    globs.map { |file| Dir.glob(file) }
  end
end
