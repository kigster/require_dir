require 'spec_helper'

RSpec.describe 'RequireDir::Loader' do
  context 'when loading files from a directory' do
    before do
      RequireDir.init_from_source(__FILE__, 2, { debug: ENV['DEBUG'] })
    end

    context 'using a non-recursive method #dir' do
      it 'should define constants defined in that folder, but not sub-folders' do
        expect(defined?(RequireDir::Tester)).to be_falsey
        RequireDir.dir('spec/loader/loader-test')
        expect(defined?(RequireDir::Tester)).to be_truthy
        expect(defined?(RequireDir::Subfolder::Tester)).to be_falsey
      end
    end

    context 'using a recursive method #dir_r' do
      it 'should define constants defined in the folder and its subfolders' do
        expect(defined?(RequireDir::Subfolder)).to be_falsey
        RequireDir.dir_r('spec/loader/loader-test')
        expect(defined?(RequireDir::Subfolder::Tester)).to be_truthy
      end
    end
  end

  context 'when included in multiple modules' do
    module Boo
      extend RequireDir
      init_from_source __FILE__, 2
    end
    module Moo
      extend RequireDir
      init_from_source __FILE__
    end

    it 'should support different roots for each module' do
      expect(Kernel).to receive(:require).with(Dir.pwd + '/spec/loader/loader-test/subfolder/tester.rb').exactly(4).times
      Boo.dir('spec/loader/loader-test/subfolder')
      Moo.dir('loader-test/subfolder')
      Boo.dir('spec/loader/loader-test/subfolder')
      Moo.dir('loader-test/subfolder')
    end
  end

end
