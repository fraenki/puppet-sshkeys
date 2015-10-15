require 'puppet-lint/tasks/puppet-lint'
require 'puppetlabs_spec_helper/rake_tasks'
require 'rubocop/rake_task'

RuboCop::RakeTask.new

PuppetLint.configuration.ignore_paths = ['vendor/**/*.pp']
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.relative = true

task default: [:validate, :lint, :spec]

desc 'Populate CONTRIBUTORS file'
task :contributors do
  system("git log --format='%aN' | sort -u > CONTRIBUTORS")
end
