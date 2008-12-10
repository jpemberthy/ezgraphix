require 'hpricot'

module Ezgraphix
  module Helper

    
    #At the moment just will return render_simple for simple graphs, 2 based variables.
    def get_style(g)
      case g.c_type
      when 'col3d'
        return 'render_simple'
      when 'bar2d'
        return 'render_simple'
      when 'col2d'
        return 'render_simple'
      end
    end
    
    #needs more work
    def render_ezgraphix(g)
      action = get_action(g.c_type)
      #data_url = CGI.escapeHTML(url_for(:controller => 'graphs', :action => action, :only_path => false, :start_date => "#{@start_date}", :end_date => "#{@end_date}", :graph_id => "#{g.id_name}"))
      h = Hpricot("<script type='text/javascript'> var activity = new FusionCharts('#{g.f_type}', '#{g.id_name}', '#{g.w}', '#{g.h}','0','0'); activity.setDataURL('#{data_url}'); activity.render('#{g.id_name}');</script>")
      h.to_html
    end
      

    
    #converts nice and cool option names in the original large names.
    def parse_options(options)
      original_names = Hash.new
      
      options.each{|k,v| 
        when :y_name
          parsed_hash['yAxisName'] = v
        when :caption
          parsed_hash['caption'] = v
        when :prefix
          parsed_hash['numberPrefix'] = v
        when :precision
          parsed_hash['decimalPrecision'] = v
        when :div_line_precision
          parsed_hash['divlinedecimalPrecision'] = v
        when :limits_precision
          parsed_hash['limitsdecimalPrecision'] = v
        when :f_number
          parsed_hash['formatNumber'] = v
        when :f_number_scale
          parsed_hash['formatNumberScale'] = v
        when :rotate
          parsed_hash['rotateNames']  = v  
        when :background
          parsed_hash['bgColor'] = v
        when :line
          parsed_hash['lineColor'] = v
        when :names
          parsed_hash['showNames'] = v
        when :values
          parsed_hash['showValues'] = v
        when :limits
          parsed_hash['showLimits'] = v
        when :y_lines
          parsed_hash['numdivlines'] = v
        when :p_y
          parsed_hash['parentYAxis'] = v
        when :dec_separator
          parsed_hash['decimalSeparator'] = v
        when :left_label_name
          parsed_hash['PYAxisName'] = v
        when :right_label_name
          parsed_hash['SYAxisName'] = v
        when :x_name
          parsed_hash['xAxisName'] = v
        end
        }
    end    
    
  end
end