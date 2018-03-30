require 'forwardable'

require 'require_dir/version'
require 'require_dir/loader'
require 'require_dir/initializer'


#
# This module should be used to enable directory-wide
# requiring of dependent ruby files. Recursive is also supported.
#
# @example of the usage:
#
#        module Foo
#          class Bar
#             RequireDir.enable(self, __FILE__)
#          end
#        end
#        Foo::Bar.dir_r 'foo/bar/commands' # loads all 'foo/bar/commands/**.rb' files
#        Foo::Bar.dir_r 'foo/bar/commands' # loads all 'foo/bar/commands/*.rb' files
#
module RequireDir
  class << self
    # @deprecated Please use {#enable_require_dir!} instead
    def included(klass)
      klass.send(:extend, RequireDir::Initializer)
      klass.send(:include, RequireDir::Initializer)
    end

    def enable_require_dir!(klass, source_file, offset = 0, **options)
      klass.send(:extend, RequireDir::Initializer)
      klass.send(:include, RequireDir::Initializer)
      klass.send(:__require_dir_init, source_file, offset, options)
    end
  end
end
