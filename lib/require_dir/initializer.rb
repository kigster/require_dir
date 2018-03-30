require 'forwardable'
module RequireDir
  module Initializer
    def self.included(base)
      base.instance_eval do
        class << self
          attr_accessor :__require_dir_loader
          extend Forwardable
          def_delegators :@__require_dir_loader, :dir, :dir_r, :require_dir, :require_dir_r

          def __require_dir_init(source, offset = 0, options = {})
            project_folder            = __require_dir_project_folder(source: source, offset: offset)
            self.__require_dir_loader = __require_dir_create_loader(options, project_folder)
          end

          def __require_dir_create_loader(options, project_folder)
            RequireDir::Loader.new(project_folder, options)
          end

          def __require_dir_project_folder(source:, offset: 0)
            dirs_up = ''
            offset.times { dirs_up << '/..' } if offset > 0
            File.dirname(File.expand_path(source + dirs_up))
          end
        end
      end
    end
  end
end
