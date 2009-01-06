    namespace :ezgraphix do
    task :dir_setup do
      Dir.mkdir("#{RAILS_ROOT}/public/FusionCharts", 0700)
      puts "created FusionCharts directory in public/"
    end
    
    task :copy_charts do
      FileUtils.cp_r("#{RAILS_ROOT}/vendor/plugins/ezgraphix/public/FusionCharts/", "#{RAILS_ROOT}/public/")
      puts "charts copied."
    end
    
    task :copy_javascript
      FileUtils.cp_r("#{RAILS_ROOT}/vendor/plugins/ezgraphix/public/javascripts/FusionCharts.js", "#{RAILS_ROOT}/public/javascripts/")
      puts "FusionCharts.js copied"
      
    desc "creates and copies all necessary files in order to use ezgraphix!"
    task :setup => [:dir_setup, :copy_charts, :copy_javascript]
  end