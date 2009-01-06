require 'rubygems'
require 'rubygems/specification'
require 'rake'
require 'spec/rake/spectask'
require 'echoe'
 
GEM = "ezgraphix"
GEM_VERSION = "1.0"
SUMMARY = "EasyGraphics for rails applications using a free and customizable chart's set."
AUTHOR = "Juan Esteban Pemberthy"
EMAIL = "jpemberthy@gmail.com"
HOMEPAGE = "http://github.com/jpemberthy/ezgraphix/tree/master"

Echoe.new(GEM, GEM_VERSION) do |p|
  p.description    = SUMMARY
  p.url            = HOMEPAGE
  p.author         = AUTHOR
  p.email          = EMAIL
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext } 


Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = %w(-fs --color)
end
  
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end
 
desc "Install the gem locally"
task :install => [:package] do
  sh %{sudo gem install pkg/#{GEM}-#{GEM_VERSION}}
end
 
desc "Create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end
