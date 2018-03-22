# RequireDir 

[![Gem Version](https://badge.fury.io/rb/require_dir.svg)](https://badge.fury.io/rb/require_dir)
[![Downloads](http://ruby-gem-downloads-badge.herokuapp.com/require_dir?type=total)](https://rubygems.org/gems/require_dir)

[![Build Status](https://travis-ci.org/kigster/require_dir.svg?branch=master)](https://travis-ci.org/kigster/warp-dir)
[![Code Climate](https://codeclimate.com/github/kigster/require_dir/badges/gpa.svg)](https://codeclimate.com/githb/kigster/require_dir)
[![Test Coverage](https://codeclimate.com/github/kigster/require_dir/badges/coverage.svg)](https://codeclimate.com/github/kigster/require_dir/coverage)
[![Issue Count](https://codeclimate.com/github/kigster/require_dir/badges/issue_count.svg)](https://codeclimate.com/github/kigster/require_dir)


This gem provides an easy way to require all file from a folder – recursively, or not.

Unlike other gems, such as `require_all`, this gem does suffer from module clobbering or changing global search paths.

## Author

This library is the work of [Konstantin Gredeskoul](http:/kig.re), &copy; 2016-2018, distributed under the MIT license.

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
  RequireDir.enable_require_dir!(self, __FILE__)
end

Mylib.require_dir('mylib/subfolder')   # loads all files in the folder 'lib/mylib/subfolder/*.rb'
Mylib.require_dir_r('mylib/subfolder') # recursive load from 'lib/mylib/subfolder/**/*.rb'

```

You can also use shorcuts `dir` and `dir_r`, which are equivalent to `require_dir` and  `require_dir_r` respectively.


### Offset

You can optionally load the library using `init_with_offset` method, which allows you 
to initialize the library from a file located not directly under lib, but further down below.

Say you want to initialize the library from `lib/mylib/subfolder/mymodule.rb`. But you want to 
be able to later use RequireDir to load files relative to `lib`. This is how you would do that:


```ruby
# file 'lib/mylib/subfolder/mymodule.rb' -- top level file for a gem 'mylib'
require 'require_dir'
module Mylib
  module SubFolder
    RequireDir.enable_require_dir!(self, __FILE__, 1)
  end
end

Mylib.dir('mylib/subfolder')   # loads all files in the folder 'lib/mylib/subfolder/*.rb'
Mylib.dir_r('mylib/subfolder') # recursive load from 'lib/mylib/subfolder/**/*.rb'
```

### Load Errors

The library attempts to catch load errors and print out (to STDERR) meaningful and colorful messages.

But sometimes that's not enough – and you may want to see which file was RequireDir loading *just before* it
exploded. You can enable debugging output using two methods:

 * Set environment variable `REQUIRE_DIR_DEBUG` 
 * Initialize library with options hash, setting:

```ruby
  RequireDir.enable_require_dir!(self, __FILE__, 0, debug: true)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kigster/require_dir.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

