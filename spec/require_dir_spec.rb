require 'spec_helper'

describe RequireDir do
  module TestModule
    RequireDir.enable_require_dir!(self, __FILE__)
  end

  it 'has a version number' do
    expect(RequireDir::VERSION).not_to be nil
  end

  context 'deprecated usage' do
    before do
      TestModule.instance_eval do
        include RequireDir
        __require_dir_init(__FILE__)
      end
    end
    it 'still works despite deprecation' do
      expect(TestModule).to respond_to(:__require_dir_init)
    end
  end

  context 'Object' do
    before { RequireDir.enable_require_dir!(Object, __FILE__) }

    it 'still works despite deprecation' do
      expect(Object).to respond_to(:dir_r)
    end
  end

  context '#project_folder_from' do
    it 'correctly calculates project folder' do
      expect(TestModule.__require_dir_project_folder(source: __FILE__)).to eql(Dir.pwd + '/spec')
    end

    it 'correctly calculates project folder using offset' do
      expect(TestModule.__require_dir_project_folder(source: __FILE__, offset: 1)).to eql(Dir.pwd)
    end
  end
end
