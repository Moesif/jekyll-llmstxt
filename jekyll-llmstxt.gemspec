require_relative "lib/jekyll-llmstxt/version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-llmstxt"
  spec.version       = Jekyll::Llmstxt::VERSION
  spec.authors       = ["Kyle Gao"]
  spec.email         = ["kyleygao@gmail.com"]

  spec.summary       = "Generate llms.txt for Jekyll site"
  spec.homepage      = "https://github.com/kylegao91/jekyll-llmstxt"
  spec.license       = "MIT"


  spec.files         = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README.md", "LICENSE.txt"]
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.4.0"

  spec.add_dependency "jekyll", ">= 3.7", "< 5.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
