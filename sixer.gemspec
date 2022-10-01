$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "sixer/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name          = "sixer"
  s.version       = Sixer::VERSION
  s.authors       = ["Nisanth Chunduru"]
  s.email         = ["nisanth074@gmail.com"]
  s.homepage      = "https://github.com/nisanth074/gmail"
  s.summary       = "Unofficial gem for Cloud66 API"
  s.description   = "Unofficial gem for Cloud66 API https://developers.cloud66.com/#introduction"

  s.files = Dir["{lib}/**/*", "README.md"]

  s.add_dependency "httparty"
  s.add_dependency "json"
  s.add_dependency "activesupport"

  s.add_development_dependency "rspec", '~> 3.9'
  s.add_development_dependency "pry"
  s.add_development_dependency "rake"
end