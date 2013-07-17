#server.rb
#Provides methods to handle stored information gathering

class Server
 
  def initialize
    puts("[Server] Initializing...")    
  end
  
  def get(appId, contextId, natureId, value)
    puts("[Server][get] Request received! appId: #{appId} - contextId: #{contextId} - natureId: #{natureId} - value: #{value}")
    
    MetricsController.instance.cache.retrieve
  end

  def getAll(appId, *values)
    puts("[Server][getAll] Data received! appId: #{appId} - values: #{values}")
    
    MetricsController.instance.cache.retrieve
  end
end