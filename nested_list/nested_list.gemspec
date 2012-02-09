# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nested_list/version"

Gem::Specification.new do |s|
  s.name = "nested_list"
  s.version = NestedList::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors = ["Dina Zhyliaieva"]
  s.email = %q{din.chick@gmail.com}
  s.description = %q{A Nested list is library that allow to generate a set of options to use it simple select element. The options are generated in such way that you can get nested drop-down list  saved system style just  using simple <select/> element.}

  s.rubyforge_project = "nested_list"
  
  s.files         = "git ls-files".split("\n")
  s.test_files    = "git ls-files -- {test,spec,features}/*".split("\n")
  s.executables   = "git ls-files -- bin/*".split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
