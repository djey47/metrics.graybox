#collector.rb
#Provides methods to handle information storage

class Collector
 
  def initialize
    puts("[Collector] Initializing...")    
  end
  
  def add(appId, contextId, natureId, value)
    puts("[Collector][add] Data received! appId: #{appId} - contextId: #{contextId} - natureId: #{natureId} - value: #{value}")
    
    MetricsController.instance.cache.store
  end

  def addAll(appId, *values)
    puts("[Collector][addAll] Data received! appId: #{appId} - values: #{values}")
    
    MetricsController.instance.cache.store
  end
end