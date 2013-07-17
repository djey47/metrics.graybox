#server.rb
#Provides methods to handle stored information gathering

class Server
 
  def initialize
    puts("[Server] Initializing...")    
  end
  
  def get(appId, contextId, natureId)
    puts("[Server][get] Request received! appId: #{appId} - contextId: #{contextId} - natureId: #{natureId}")
    
    MetricsController.instance.cache.retrieve
  end

  def getAll(appId)
    puts("[Server][getAll] Request received! appId: #{appId}")
    
    MetricsController.instance.cache.retrieve
  end
end