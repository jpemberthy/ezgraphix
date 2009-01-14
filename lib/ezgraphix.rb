# == ezgraphix.rb
# This file contains the Ezgraphix module, and the Ezgraphix::Graphic class.
#
# == Summary
# A ruby gem to generate flash based graphics 
# for rails applications using a free and customizable chart's set.(also acts as a rails/plugin)
#
# == contact
#
# Author::    Juan E Pemberthy
# Mail:: jpemberthy@gmail.com
# Copyright:: Copyright (c) 2008
# License::   Distributes under MIT License.

unless defined? Ezgraphix
  module Ezgraphix
    require File.dirname(__FILE__) + '/ezgraphix/ezgraphix_helper'
    require 'builder'

   # This class contains the neccesary methods and attributes to render a Graphic,
   # most of time you will be playing with the render_options and _data_ attributes to
   # define the graphic's properties, also you can re-define the those properties easily by accessing them
   # at any time.
   #
   # == Example
   # Define the Graphic in your controller.
   #   @g = Ezgraphix::Graphic.new  # render_options can also be passed from here, 
   #                                # @g = Ezgraphix::Graphic.new(:div_name => 'my_graph', :w => 400)
   #
   #   @g.defaults
   #   => {:c_type=>'col3d', :div_name=>'ez_graphic', :w=>300, :h=>300}
   #   
   #   @g.render_options #equals to defaults if not options were passed to the initializer.
   #   => {:c_type=>'col3d', :div_name=>'ez_graphic', :w=>300, :h=>300}
   #
   # It's always a good idea to change the div_name if your planning to render more
   # than one Graphic in the same page, this makes the graphic unique.
   #   @g.render_options(:div_name => 'my_graph')
   #   => {:c_type=>'col3d', :div_name=>'my_graph', :w=>300, :h=>300} 
   #
   # In order to render, you have to feed the graphic with data you want to show, Ezgraphix uses
   # a Hash to represent that data where the keys represents names, for example:
   #   @g.data(:ruby => 1, :perl => 2, :smalltalk => 3)
   #
   # With this information, the graphic will be a column 3D, with a size of 300x300 pixels, indentified with the
   # 'my_graph' name, with 3 columns containing the names: 'ruby', 'perl', and 'smalltalk' for the values 1,2,3 respectively.
   #
   # To render the graphic, from a view call the render_ezgraphix method defined in the Ezgraphix::Helper module.
   #  <%= render_ezgraphix @g %>
   #
    class Graphic
      include EzgraphixHelper
      
      #Hash containing the names and labels to render.
      attr_accessor :data
      
      # Hash containing all the render options. basic options are:
      # * :c_type. Chart type to render.
      # * :div_name. Div's tag name for the graphic, should be unique.
      # * :w. Width in pixels.
      # * :h. Height in pixels.
      # Full list of options are listed below render_options
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
      
      #Returns defaults render options.
      def defaults
        {:c_type => 'col3d', :w => 300, :h => 300, :div_name => 'ez_graphic'}
      end

      #Receives a Hash containing a set of render options that will be merged with the current configuration.
      #Full set of options are:
      #Basics:
      #* :c_type -- Chart type to render, default: 'col3d' for Column 3D, options are:
      #  'bar2D' for Bar 2D
      #  'col2D' for Column 2D
      #  'pie2D' for Pie 2D
      #  'pie3D' for Pie 3D
      #* :div_name -- Div's tag name for the graphic, would be unique, default: 'ez_graphic'
      #* :w -- Width in pixels, default: 300
      #* :h -- Height in pixels, default: 300
      #* :caption -- Graphic's caption, default: ''
      #* :subcaption -- Graphic's subcaption, default: ''
      #* :y_name -- Y axis name, default: ''
      #* :x_name -- X axis name, default: ''
      #Numbers:
      #* :prefix -- Prefix to values defined in the _data_ attribute, default: nil, some prefix could be
      #  :prefix => '$' or :prefix => '€'
      #* :precision -- Number of decimal places to which all numbers on the chart would be rounded to, default: 2
      #* :f_number -- Format number. if set to 0, numbers will not use separator, if set to 1 numbers will use separator, default: 
      #* :d_separator -- Decimal Separator, default: '.' 
      #* :t_separator -- Thousand Separator, default: ','
      #Design:
      #* :background. Background Color
      #* :names -- Hide/Show(0/1) labels names, default: 1
      #* :values. Hide/Show(0/1) Values, default: 1
      #* :limits. Hide/Show(0/1) Limits.
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
