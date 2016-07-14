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

    def debug?
      options[:debug] || ENV['REQUIRE_DIR_DEBUG']
    end

    def dir(folder, recursive = false)
      folder = "/#{folder}" unless folder.start_with? '/'
      ::Dir.glob(project_root + folder + (recursive ? '/**/*.rb' : '/*.rb') ) do |file|
        puts "Loading #{file}" if debug?
        begin
          Kernel.require(file)
        rescue SyntaxError, LoadError => e
          len = file.length + 6
          STDERR.puts '—' * len
          STDERR.puts "⇨  #{file.bold.yellow} ⇦".bold.white
          STDERR.puts '—' * len
          STDERR.puts e.message.bold.red
          STDERR.puts '—' * len
          STDERR.puts e.backtrace.join("\n").bold.black if e.backtrace && !e.backtrace.empty?
          exit 1
        end
      end


    end

    def dir_r(folder)
      dir(folder, true)
    end

  end
end
