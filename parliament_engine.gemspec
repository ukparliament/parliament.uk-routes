lib = File.expand_path('../lib/parliament', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# Maintain your gem's version:
require "engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "parliament_engine"
  s.version     = Parliament::Engine::VERSION
  s.authors     = ["Bryony Watson"]
  s.email       = ["watsonb@parliament.uk"]
  s.summary     = "Summary of parliament_engine."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.2"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "sqlite3"
end
