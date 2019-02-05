$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "jsql/version"
# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "jsql"
  spec.version     = Jsql::VERSION
  spec.authors     = ["Adam Radecki"]
  spec.email       = ["adam.radecki@jsql.pl"]
  spec.homepage    = "https://rubygems.org/gems/jsql"
  spec.summary     = "Gem used to communicate with JSQL application"
  spec.description = "none"
  spec.license     = "MIT"

  gem 'http'
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org/gems/jsql"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 5.2.2"

  spec.add_development_dependency "pg"
end
