require 'hpricot'
require 'builder'

module Ezgraphix
  module Helper

    #At the moment just will return render_simple for simple graphs, 2 based variables.
    def get_style(g)
      case g.c_type
      when 'col3d'
        style = 'render_simple'
      when 'bar2d'
        style = 'render_simple'
      when 'col2d'
        style = 'render_simple'
      end
      style
    end
    
    def render_ezgraphix(g)
      action = get_action(g.c_type)
      xml_data = g.to_xml
      h = Hpricot("<script type='text/javascript'> var activity = new FusionCharts('#{g.f_type}', '#{g.id_name}', '#{g.w}', '#{g.h}','0','0'); activity.setDataURL(''); activity.render('#{g.id_name}');</script>")
      h.to_html
    end
        
    #converts nice and cool option names in the original large names.
    def parse_options(options)
      original_names = Hash.new
      
      options.each{|k,v| 
        when :y_name
          original_names['yAxisName'] = v
        when :caption
          original_names['caption'] = v
        when :prefix
          original_names['numberPrefix'] = v
        when :precision
          original_names['decimalPrecision'] = v
        when :div_line_precision
          original_names['divlinedecimalPrecision'] = v
        when :limits_precision
          original_names['limitsdecimalPrecision'] = v
        when :f_number
          original_names['formatNumber'] = v
        when :f_number_scale
          original_names['formatNumberScale'] = v
        when :rotate
          original_names['rotateNames']  = v  
        when :background
          original_names['bgColor'] = v
        when :line
          original_names['lineColor'] = v
        when :names
          original_names['showNames'] = v
        when :values
          original_names['showValues'] = v
        when :limits
          original_names['showLimits'] = v
        when :y_lines
          original_names['numdivlines'] = v
        when :p_y
          original_names['parentYAxis'] = v
        when :dec_separator
          original_names['decimalSeparator'] = v
        when :left_label_name
          original_names['PYAxisName'] = v
        when :right_label_name
          original_names['SYAxisName'] = v
        when :x_name
          original_names['xAxisName'] = v
        end
        }
    end    
    
  end
end