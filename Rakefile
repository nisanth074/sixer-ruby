task :publish_to_rubygems do
  `gem build magicbell.gemspec`
  require_relative "lib/sixer"
  `gem push magicbell-#{Sixer::VERSION}.gem`
end
