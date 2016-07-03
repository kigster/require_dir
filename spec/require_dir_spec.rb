require 'spec_helper'

describe RequireDir do
  module TestModule
    extend RequireDir
  end

  it 'has a version number' do
    expect(RequireDir::VERSION).not_to be nil
  end

  it 'correctly calculates project folder' do
    expect(TestModule.project_folder_from(source: __FILE__)).to eql(Dir.pwd + '/spec')
  end

  it 'correctly calculates project folder using offset' do
    expect(TestModule.project_folder_from(source: __FILE__, offset: 1)).to eql(Dir.pwd)
  end
end
