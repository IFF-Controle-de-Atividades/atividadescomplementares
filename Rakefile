#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rspec/core/rake_task'

desc "Carregador Personalizado para o RSpec"

RSpec::Core::RakeTask.new do |t|
	t.name= :spec
	t.pattern=  "spec/**/*/*.spec.rb"
	t.skip_bundler= false
	t.gemfile= File.expand_path("~/Gemfile")
	t.verbose= true
	t.rspec_opts= ["--color"]
end

Atividadescomplementares::Application.load_tasks
