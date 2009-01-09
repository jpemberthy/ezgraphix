# A ruby gem to generate flash based graphics 
# for rails applications using a free and customizable chart's set.(also acts as a rails/plugin)

# Author::    Juan E Pemberthy
# Mail:: jpemberthy@gmail.com
# Copyright:: Copyright (c) 2008
# License::   Distributes under MIT License.

unless defined? Ezgraphix
  module Ezgraphix
    require File.dirname(__FILE__) + '/ezgraphix/ezgraphix_helper'
    require 'builder'

   # This class holds the letters in the original
   # word or phrase. The is_anagram? method allows us
   # to test if subsequent words or phrases are
   # anagrams of the original.
    class Graphic
      include EzgraphixHelper
      
      #Hash containing the names and labels to render, example: {:ruby => 1, :perl => 2, :smalltalk => 3}
      attr_accessor :data
      
      # Hash containing all the render options. basic options are:
      # * :c_type. Chart type to render.
      # * :div_name. Div's tag name for the graphic, would be unique.
      # * :w. Width in pixels.
      # * :h. Height in pixels.
      # Full list of options can be found in the method specification Graphic#render_options
      attr_accessor :render_options
      
      COLORS = ['AFD8f6', '8E468E', '588526', 'B3A000', 'B2FF66',
                'F984A1', 'A66EDD', 'B2FF66', '3300CC', '000033',
                '66FF33', '000000', 'FFFF00', '669966', 'FF3300']
                
      #Creates a new Graphic with the given _options_, if no _options_ are specified,
      #the new Graphic will be initalized with the Graphic#defaults options.
      def initialize(options={})
        @render_options = defaults.merge!(options)
        @data = Hash.new
      end
      
      #Returns defaults render options, => {:c_type => 'col3d', :w => 300, :h => 300, :div_name => 'basic_graph'}
      def defaults
        {:c_type => 'col3d', :w => 300, :h => 300, :div_name => 'basic_graph'}
      end

      #Receives a Hash containing a set of render options that will be merged with the current configuration.
      #Full set of options are:
      #* :c_type. Chart type to render.
      #* :div_name. Div's tag name for the graphic, would be unique.
      #* :w. Width in pixels.
      #* :h. Height in pixels.
      #* :caption. Graphic's caption
      #* :prefix. Prefixs to values defined in the _data_ attribute.
      #* :precision. Precision to values defined in the _data_attribute.
      #* :f_number. Format number.
      #* :background. Background Color
      #* :names. Hide/Show labels names.
      #* :values. Hide/Show Values.
      #* :limits. Hide/Show limits
      #* :separator. Decimal Separator. 
      def render_options(options={})
        @render_options.merge!(options)
        @render_options
      end
      
     #Returns the Graphic's type.
      def c_type
        self.render_options[:c_type]
      end

      #Returns the Graphic's width.
      def w
        self.render_options[:w]
      end

      #Returns the Graphic's height.
      def h  
        self.render_options[:h]
      end

      #Returns the div's tag name would be unique if you want to render multiples graphics in the same page.
      def div_name
        self.render_options[:div_name]
      end
      
      
      #Returns a random color from the Graphic#COLORS collection.   
      def rand_color
        COLORS[rand(Graphic::COLORS.size - 1)]
      end
      
      #Builds the xml to feed the chart.
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
      
  end  
 end
end
