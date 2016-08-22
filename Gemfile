source 'https://rubygems.org'

puppetversion = ENV['PUPPET_VERSION']

gem 'rake'
gem 'metadata-json-lint'
gem 'puppet', puppetversion
gem 'puppet-lint'
gem 'rspec-puppet'
gem 'puppetlabs_spec_helper'
gem 'rubocop', require: false if RUBY_VERSION >= '2.0.0'
# try to be compatible with ruby 1.9.3
gem 'json', '< 2.0.0'
gem 'json_pure', '< 2.0.0'
