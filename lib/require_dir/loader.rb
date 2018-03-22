require 'require_dir/version'
require 'colored2'
module RequireDir
  #
  # This class is meant to be instantiated per project/library, and then used to load
  # en masse ruby files from a directory.
  class Loader

    attr_accessor :project_root, :options

    class << self
      attr_accessor :stderr
    end

    self.stderr = STDERR

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
          Kernel.require file
        rescue SyntaxError, LoadError => e
          report_error(e, file)
          raise(e)
        end
      end
    end

    def dir_r(folder)
      dir(folder, true)
    end

    alias require_dir dir
    alias require_dir_r dir_r

    private

    def report_error(e, file)
      len = file.length + 6
      outputs '—' * len
      outputs "⇨  #{file.bold.yellow} ⇦".bold.white
      outputs '—' * len
      outputs e.message.bold.red
      outputs '—' * len
      outputs e.backtrace.join("\n").bold.black if e.backtrace && !e.backtrace.empty?
    end

    def outputs(*args)
      self.class.stderr.puts(*args) if self.class.stderr
    end

  end
end
