class PathParser

  def check_globs(files)
    has_glob = /\*/
    new_files = files

    files.each do |file|
      unless (has_glob =~ file).nil?
        new_files << file
      end
    end

    new_files.flatten
  end

end
