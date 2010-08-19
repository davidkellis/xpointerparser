require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
  s.name = "xpointer"
  s.summary = "An XPointer parser."
  s.description= "A partial implementation of an XPointer (http://www.w3.org/TR/xptr-framework/) parser."
  s.requirements = [ 'None' ]
  s.version = "0.0.1"
  s.author = "David Ellis"
  s.email = "davidkellis@gmail.com"
  s.homepage = "http://david.davidandpenelope.com"
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>=1.9'
  s.files = Dir['**/**']
  s.executables = []
  s.test_files = []
  s.has_rdoc = false
  
  s.add_runtime_dependency 'treetop', '>= 1.4.8'
end

Rake::GemPackageTask.new(spec).define