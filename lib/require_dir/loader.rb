require 'require_dir/version'

module RequireDir
  #
  # This class is meant to be instantiated per project/library, and then used to load
  # en masse ruby files from a directory.
  class Loader

    attr_accessor :project_root, :options

    def initialize(root_dir, options = {})
      raise ArgumentError.new("Folder #{root_dir} is not found") unless Dir.exist?(root_dir)
      self.project_root = root_dir
      self.options = options
    end

    def dir(folder, recursive = false)
      folder = "/#{folder}" unless folder.start_with? '/'
      loader = self
      ::Dir.glob(project_root + folder + (recursive ? '/**/*.rb' : '/*.rb') ) do |file|
        puts "Loading #{file}" if loader.options[:debug]
        Kernel.require(file)
      end
    end

    def dir_r(folder)
      dir(folder, true)
    end

  end
end
