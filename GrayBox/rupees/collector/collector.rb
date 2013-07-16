#collector.rb
#Provides methods to handle information storage

require_relative '../controller/controller'

class Collector
 
  def initialize
    puts("[Collector] Initializing...")    
  end
  
  def add(appId, contextId, natureId, value)
    puts("[Collector] Data received! appId: #{appId} - contextId: #{contextId} - natureId: #{natureId} - value: #{value}")
    
    MetricsController.instance.cache.store
  end
end