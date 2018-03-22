require 'forwardable'
module RequireDir
  module Initializer
    attr_accessor :loader
    class << self
      def included(base)
        base.instance_eval do
          class << self
            attr_accessor :loader
            extend Forwardable
            def_delegators :@loader, :dir, :dir_r, :require_dir, :require_dir_r
          end
        end
      end
    end

    def init(source, offset = 0, options = {})
      project_folder = project_folder_from(source: source, offset: offset)
      self.loader    = create_loader(options, project_folder)
    end

    def create_loader(options, project_folder)
      RequireDir::Loader.new(project_folder, options)
    end

    def project_folder_from(source:, offset: 0)
      dirs_up = ''
      offset.times { dirs_up << '/..' } if offset > 0
      File.dirname(File.expand_path(source + dirs_up))
    end
  end
end
