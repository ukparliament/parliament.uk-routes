$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "parliament_routing_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "parliament_routing_engine"
  s.version     = ParliamentRoutingEngine::VERSION
  s.authors     = ["Bryony Watson"]
  s.email       = ["watsonb@parliament.uk"]
  s.summary     = "Summary of ParliamentRoutingEngine."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.2"
  s.add_development_dependency "rspec-rails"

  s.add_development_dependency "sqlite3"
end
