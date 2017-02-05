#!/usr/bin/env rake

require 'rubocop/rake_task'

desc 'Run RuboCop on the lib directory'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb']
end

desc 'Build the gem'
task build: :sanity do
  sh 'gem', 'build', *Dir['*.gemspec']
end
