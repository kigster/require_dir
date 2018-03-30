[![Build Status](https://travis-ci.org/kigster/require_dir.svg?branch=master)](https://travis-ci.org/kigster/require_dir)
[![Maintainability](https://api.codeclimate.com/v1/badges/ad8aceb1bb3c22f72194/maintainability)](https://codeclimate.com/github/kigster/require_dir/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ad8aceb1bb3c22f72194/test_coverage)](https://codeclimate.com/github/kigster/require_dir/test_coverage)    
[![Gem Version](https://badge.fury.io/rb/require_dir.svg)](https://badge.fury.io/rb/require_dir)
[![Downloads](http://ruby-gem-downloads-badge.herokuapp.com/require_dir?type=total)](https://rubygems.org/gems/require_dir)

----

# RequireDir 

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
  # You must pass __FILE__ so that the library knows the "root" of your sources.
  RequireDir.enable_require_dir!(self, __FILE__)

  dir_r 'mylib/cli'
  dir   'mylib/commands'
end
```

You literally have access to two methods (with aliases):

 * `dir_r` (or `require_dir_r`) loads all ruby files recursively
 * `dir` (or `require_dir`) loads files non-recursively


### Offset

If your library's top required file is not at the very top level of the directory structure, 
which might happen, if, say you have a gem named `app-foo`, and your primary required file is
located in `lib/app/foo.rb`, in this case you will need to pass an offset of 1 to the `enable_require_dir!` 
method to properly initialize recursive loading:

```ruby
# 'lib/app/foo.rb' 
# i.e. this file is one level deep in the source tree of this library:

require 'require_dir'

module App
  module Foo
    # offset is 1, because the current file is 1 level deep into the source tree.
    RequireDir.enable_require_dir!(self, __FILE__, 1) 

    dir_r 'app/foo/bar'   # loads all files in the folder 'app/foo/bar/**.rb'
  end
end
```

### Load Errors

The library attempts to catch load errors and print out (to STDERR) meaningful and colorful messages.

But sometimes that's not enough – and you may want to see which file was RequireDir loading *just before* it
exploded. You can enable debugging output using two methods:

 * Set environment variable `REQUIRE_DIR_DEBUG` 
 * Initialize library with options hash, setting:

```ruby
module Foo
  RequireDir.enable_require_dir!(self, __FILE__, 0, debug: true)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kigster/require_dir.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

