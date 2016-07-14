require 'require_dir/version'
require 'require_dir/loader'
require 'forwardable'
module RequireDir
  attr_accessor :loader

  def project_folder_from(source: , offset: 0)
    dirs_up = ''
    offset.times { dirs_up << '/..' } if offset > 0
    File.dirname(File.expand_path(source +  dirs_up))
  end

  def init_with_offset(source, offset = 0, options = {})
    project_folder = project_folder_from(source: source, offset: offset)
    self.loader = RequireDir::Loader.new(project_folder, options)
  end

  def init(source, options = {})
    init_with_offset(source, 0, options)
  end

  alias_method :init_from_source, :init_with_offset

  extend Forwardable
  def_delegators :@loader, :dir, :dir_r

  extend self
end
