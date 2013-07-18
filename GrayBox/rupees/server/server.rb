#server.rb
#Provides methods to handle stored information gathering

require_relative '../model/dataitem'

class Server
 
  def initialize
    puts("[Server] Initializing...")    
  end
  
  def get(appId, contextId, natureId)
    puts("[Server][get] Request received! appId: #{appId} - contextId: #{contextId} - natureId: #{natureId}")
    
    keys = []
    keys << buildKey(appId, contextId, natureId)
    MetricsController.instance.cache.retrieve keys
  end

  def getAll(appId)
    puts("[Server][getAll] Request received! appId: #{appId}")
    
    MetricsController.instance.cache.retrieve
  end
  
  
  def buildKey(appId, contextId, natureId)
    "#{appId}|#{contextId}|#{natureId}"  
  end         
end