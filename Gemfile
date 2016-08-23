source 'https://rubygems.org'

puppetversion = ENV['PUPPET_VERSION']

group :test do
  gem 'rake'
  gem 'metadata-json-lint'
  gem 'puppet-lint'
  gem 'rspec-puppet', require: false, git: 'https://github.com/rodjek/rspec-puppet.git'
  gem 'puppetlabs_spec_helper'
  gem 'rubocop-rspec', '~> 1.6', require: false if RUBY_VERSION >= '2.3.0'
  # try to be compatible with ruby 1.9.3
  gem 'json', '< 2.0.0', require: false if RUBY_VERSION < '2.0.0'
  gem 'json_pure', '< 2.0.0', require: false if RUBY_VERSION < '2.0.0'
end

group :development do
  gem 'travis-lint',  require: false
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion.to_s, require: false, groups: [:test]
else
  gem 'facter', require: false, groups: [:test]
end

ENV['PUPPET_VERSION'].nil? ? puppetversion = '~> 4.0' : puppetversion = ENV['PUPPET_VERSION'].to_s
gem 'puppet', puppetversion, require: false, groups: [:test]
