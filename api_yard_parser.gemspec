$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "api_yard_parser/version"
# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "api_yard_parser"
  s.version     = ApiYardParser::VERSION
  s.authors     = ["Thiago Coutinho"]
  s.email       = ["thiago@osfieo.com / thiago.coutinho@locaweb.com.br"]
  s.homepage    = ""
  s.summary     = "This gem parse a yard doc and generate a page with api description"
  s.description = "This gem parse a yard doc and generate a page with api description"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.16"
  s.require_path = 'lib'
end
