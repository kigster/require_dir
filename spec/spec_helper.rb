$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'require_dir'

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
