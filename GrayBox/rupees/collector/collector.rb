#collector.rb
#Provides methods to handle information storage
class Collector
  
  def add(appId, contextId, natureId, value)
    puts("[Collector] Data received! appId: #{appId} - contextId: #{contextId} - natureId: #{natureId} - value: #{value}")
        
    #Should call cache here
  end
end