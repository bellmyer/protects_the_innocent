# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{protects_the_innocent}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jaime Bellmyer"]
  s.date = %q{2009-02-15}
  s.description = %q{Uses the Faker gem to turn your database of real-world data into realistic, obfuscated seed data.  Use it for demos, testing, or passing out to other developers without revealing proprietary information.  It will obfuscate only the models and fields you specify.}
  s.email = %q{ruby@bellmyer.com}
  s.has_rdoc = false
  s.homepage = %q{http://github.com/bellmyer/protects_the_innocent}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{0.1}
  s.summary = %q{Create realistic seed/demo data out of your production data without compromising security.}

  s.add_dependency(%q<faker>, [">= 0.3.1"])
end

