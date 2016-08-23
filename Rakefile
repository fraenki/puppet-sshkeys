require 'puppet-lint/tasks/puppet-lint'
require 'puppetlabs_spec_helper/rake_tasks'

if RUBY_VERSION >= '2.0.0'
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new
end

exclude_paths = %w(
  pkg/**/*
  vendor/**/*
  .vendor/**/*
  spec/**/*
)
PuppetLint.configuration.ignore_paths = exclude_paths
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.relative = true

desc 'Run acceptance tests'
RSpec::Core::RakeTask.new(:acceptance) do |t|
  t.pattern = 'spec/acceptance'
end

desc 'Run tests validate, lint, spec'
task test: [
  :validate,
  :lint,
  :spec,
]
