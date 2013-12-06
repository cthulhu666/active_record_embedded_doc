$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "active_record_embedded_doc/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "active_record_embedded_doc"
  s.version     = ActiveRecordEmbeddedDoc::VERSION
  s.authors     = ["Jakub Głuszecki"]
  s.email       = ["jakub.gluszecki@gmail.com"]
  s.homepage    = "https://github.com/cthulhu666/active_record_embedded_doc"
  s.summary     = "Mongo-like embedded documents for ActiveRecord+PostgreSQL"
  s.description = "Mongo-like embedded documents for ActiveRecord+PostgreSQL using json column type"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0"
  s.add_dependency "hashie"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "faker"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "pg"
end
