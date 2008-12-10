unless defined? Ezgraphix
  
  module Ezgraphix
    
    #Graphic sounds good but maybe a lot of ppl will be already using that name for a class
    #will change it!
    class Graphic
      
      attr_accessor :c_type, :w, :h, :id_name
      
      def initialize(options={})
        options.merge!(self.defaults)
        @c_type = options[:c_type]
        @w = options[:w]
        @h = options[:y]
        @id_name = options[:id_name]
      end
      
      #c_type chart type, :w with, :h heigth
      def defaults
        {:c_type => 'bar3d', :w => 300, :h => 300, :id_name => 'basic_graph'}  
      end
      
  end
end