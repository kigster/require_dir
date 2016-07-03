# RequireDir 

[![Gem Version](https://badge.fury.io/rb/require_dir.svg)](https://badge.fury.io/rb/require_dir)
[![Downloads](http://ruby-gem-downloads-badge.herokuapp.com/require_dir?type=total)](https://rubygems.org/gems/require_dir)

<br />

[![Build Status](https://travis-ci.org/kigster/require_dir.svg?branch=master)](https://travis-ci.org/kigster/warp-dir)
[![Code Climate](https://codeclimate.com/github/kigster/require_dir/badges/gpa.svg)](https://codeclimate.com/githb/kigster/require_dir)
[![Test Coverage](https://codeclimate.com/github/kigster/require_dir/badges/coverage.svg)](https://codeclimate.com/github/kigster/require_dir/coverage)
[![Issue Count](https://codeclimate.com/github/kigster/require_dir/badges/issue_count.svg)](https://codeclimate.com/github/kigster/require_dir)


This gem provides an easy way to require all file from a folder – recursively, or not.

Unlike other gems, such as `require_all`, this gem does suffer from module clobbering or changing global search paths.

## Author

This library is the work of [Konstantin Gredeskoul](http:/kig.re), &copy; 2016.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'require_dir'
```

And then execute:

    $ bundle

Or install it with `gem` command:

    $ gem install require_dir

## Usage

Recommended usage is to include this gem's module into the top level module of your library, like so:

```ruby
# file 'lib/mylib.rb' -- top level file for a gem 'mylib'
require 'require_dir'
module Mylib
  extend RequireDir
  init_from_source __FILE__
end

Mylib.dir('mylib/subfolder')   # loads all files in the folder 'lib/mylib/subfolder/*.rb'
Mylib.dir_r('mylib/subfolder') # recursive load from 'lib/mylib/subfolder/**/*.rb'

```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/require_dir.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

