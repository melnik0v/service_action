require_relative 'lib/service_actions/version'

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "service_actions/version"

Gem::Specification.new do |gem|
  gem.name        = "service_actions"
  gem.version     = ServiceActions::VERSION
  gem.authors     = ["Alexey Melnikov"]
  gem.email       = ["alexbeat96@gmail.com"]
  gem.summary     = 'Services as actions'
  gem.description = 'Minify your controllers and move all actions logic to service objects'
  gem.homepage    = "https://github.com/melnik0v/service_actions"
  gem.license     = "MIT"
  gem.files       = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)

  gem.required_ruby_version = '>= 2.2'
  gem.require_paths = %w(lib)

  gem.add_runtime_dependency 'rails', '>= 5'
  gem.add_runtime_dependency 'dry-initializer', '>= 2.0'

  gem.add_development_dependency "bundler", ">= 1.16"
  gem.add_development_dependency "rake", ">= 10.0"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rubocop"
end
