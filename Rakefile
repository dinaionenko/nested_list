$:.push File.expand_path("../lib", __FILE__)
require 'bundler'
include Rake::DSL
require 'rake/tasklib'
require 'nested_list/tasks'
include NestedList::Task

Bundler::GemHelper.install_tasks

desc "Create a test html page to demonstrate nested list use."
task :nested_list_html_page do
  generate_html
end

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/tc_*.rb']
end
