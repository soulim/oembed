#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |task|
  task.ruby_opts = '-I lib'
end

task default: :spec
