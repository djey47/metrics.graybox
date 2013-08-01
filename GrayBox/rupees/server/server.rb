#server.rb
#Provides methods to handle stored information gathering

require_relative '../model/dataitem'
require_relative '../model/exceptions/novalueexception'

class Server
 
  def initialize
    puts("[Server] Initializing...")    
  end
  
  def get(appId, contextId, natureId)
    puts("[Server][get] Request received! appId: #{appId} - contextId: #{contextId} - natureId: #{natureId}")
    
    keys = []
    keys << buildKey(appId, contextId, natureId)
    
    results = MetricsController.instance.cache.retrieve(keys)
    
    if (results[0].value == nil)
      raise NoValueException, 'Value not found!'
    else
      results[0]
    end        
  end

  def getAll(appId)
    puts("[Server][getAll] Request received! appId: #{appId}")
    
    results = MetricsController.instance.cache.retrieveByAppId(appId)
    
    if (results.length == 0)
      raise NoValueException, 'Value not found!'
    else
      results
    end        
  end
    
  def buildKey(appId, contextId, natureId)
    "#{appId}|#{contextId}|#{natureId}"  
  end  
end