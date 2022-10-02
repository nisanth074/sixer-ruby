task :publish_to_rubygems do
  gem_name = "sixer"
  require "active_support/inflector"

  `gem build #{gem_name}.gemspec`
  require_relative "lib/#{gem_name}"
  `gem push #{gem_name}-#{gem_name.capitalize.constantize::VERSION}.gem`
end
