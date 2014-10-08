require 'puppet-lint/tasks/puppet-lint'
require 'puppetlabs_spec_helper/rake_tasks'

PuppetLint.configuration.ignore_paths = ["vendor/**/*.pp"]
PuppetLint.configuration.send("disable_80chars")
PuppetLint.configuration.relative = true

task :default => [:validate, :spec, :lint]
