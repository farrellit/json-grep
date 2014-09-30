
def filter_contents contents, keys
  if contents.kind_of? Hash
    if keys.count == 0
      return contents
    end
    filtered_content = contents.select {  |k,v| 
      k =~ Regexp.new( keys[0] )
    }
    filtered_content.each { |k,v|
      filtered_content[k] = filter_contents v, keys[1..-1]
    }
    filtered_content.select!{ |k,v| v }
    if filtered_content.count == 0
      nil
    else
      filtered_content
    end
  elsif contents.kind_of? Array
    filtered_content = contents.map{ |v|
      filter_contents v, keys[0..-1]
    }.select{ |v| v }
    if filtered_content.count == 0
      nil
    else
      filtered_content
    end
  elsif keys.count == 1 
        ("#{contents}" =~ Regexp.new("#{keys[0]}") ) ? contents : nil
  elsif keys.count == 0 
        contents 
  else
      nil
  end
end

