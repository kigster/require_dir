require 'spec_helper'

RSpec.describe 'RequireDir::Loader' do
  context 'when loading a dir' do
    before do
      RequireDir.init_from_source(__FILE__, 2, { debug: ENV['DEBUG'] })
    end

    it 'should properly define constants in a folder' do
      expect(defined?(RequireDir::Tester)).to be_falsey
      RequireDir.dir('spec/loader/loader-test')
      expect(defined?(RequireDir::Tester)).to be_truthy
      expect(defined?(RequireDir::Subfolder::Tester)).to be_falsey
    end

    it 'should properly define constants in a folder' do
      expect(defined?(RequireDir::Subfolder)).to be_falsey
      RequireDir.dir_r('spec/loader/loader-test')
      expect(defined?(RequireDir::Subfolder::Tester)).to be_truthy
    end
  end

  context 'when included in another module' do
    module Boo
      extend RequireDir
    end
    it 'should support two separate loaders' do
      RequireDir.init_from_source(__FILE__, 2)
      RequireDir.dir('spec/loader/loader-test')

    end
  end

end
