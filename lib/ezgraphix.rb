unless defined? Ezgraphix
  module Ezgraphix
    require File.dirname(__FILE__) + '/ezgraphix/ezgraphix_helper'
    require 'builder'
    
    class Graphic
      include EzgraphixHelper
      
      attr_accessor :c_type, :w, :h, :div_name, :render_options, :data
      
      COLORS = ['AFD8f6', '8E468E', '588526', 'B3A000', 'B2FF66',
                'F984A1', 'A66EDD', 'B2FF66', '3300CC', '000033',
                '66FF33', '000000', 'FFFF00', '669966', 'FF3300']
      
      def initialize(options={})
        @render_options = defaults.merge!(options)
        @data = Hash.new
      end
      
      def defaults
        {:c_type => 'col3d', :w => 300, :h => 300, :div_name => 'basic_graph'}
      end
         
      def rand_color
        COLORS[rand(Graphic::COLORS.size - 1)]
      end
      
      #builds the xml in order to feed and render the graph.
      def to_xml
        options = parse_options(self.render_options)
        g_xml = Builder::XmlMarkup.new
        escaped_xml = g_xml.graph(options) do
          self.data.each{ |k,v|
            g_xml.set :value => v, :name => k, :color => self.rand_color 
          }
        end
        escaped_xml.to_xs
      end
      
      #receives all the neccesary data in order to render the graphic
      def render_options(options={})
        @render_options.merge!(options)
        @render_options
      end
      
     #char type, ['col3d', 'bar2d', 'col2d']
      def c_type
        self.render_options[:c_type]
      end

      #width. default: 300px
      def w
        self.render_options[:w]
      end

      #height. default: 300px
      def h  
        self.render_options[:h]
      end

      #div_name for the graphix tag, default: 'basic_graphic'
      def div_name
        self.render_options[:div_name]
      end
      
  end  
 end
end
