require 'rubygems'
require 'rake'
require 'echoe'
require 'spec/rake/spectask'
 
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

Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = %w(-fs --color)
end


#Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext } 
