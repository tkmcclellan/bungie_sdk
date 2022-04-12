# frozen_string_literal: true

require_relative 'lib/bungie_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = 'bungie_sdk'
  spec.version       = BungieSdk::VERSION
  spec.authors       = ['tkmcclellan']
  spec.email         = ['the8bitgamer11@gmail.com']

  spec.summary       = 'Unofficial Bungie SDK for Ruby!'
  spec.description   = 'Incomplete, WIP, unofficial Ruby SDK for the Bungie API.'
  spec.homepage      = 'https://github.com/tkmcclellan/bungie_sdk'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/tkmcclellan/bungie_sdk'
  spec.metadata['changelog_uri'] = 'https://github.com/tkmcclellan/bungie_sdk/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject {|f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_runtime_dependency 'launchy', '~> 2.5'
  spec.add_runtime_dependency 'oauth2', '~> 1.2'
  spec.add_runtime_dependency 'sorbet-runtime', '~> 0.5'
  spec.add_runtime_dependency 'typhoeus', '~> 1.4'
  spec.add_development_dependency 'dotenv', '~> 2.7'
  spec.add_development_dependency 'sorbet', '~>0.5'
end
