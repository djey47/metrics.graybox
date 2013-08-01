#collector.rb
#Provides methods to handle information storage

require_relative '../model/dataitem'

class Collector
 
  def initialize
    puts("[Collector] Initializing...")    
  end
  
  def add(appId, contextId, natureId, value)
    puts("[Collector][add] Data received! appId: #{appId} - contextId: #{contextId} - natureId: #{natureId} - value: #{value}")
    
    key = buildKey(appId, contextId, natureId)    
    datas = []
    datas << DataItem.new(key, value) 
    
    MetricsController.instance.cache.store(datas)
  end

  def addAll(appId, datas)
    puts("[Collector][addAll] Data received! appId: #{appId} - values: #{datas}")

    toStore=[]
    datas.each { |data| toStore << DataItem.new( buildKey(appId, data["key"]["ctxId"], data["key"]["natId"]), data["value"]) }
    MetricsController.instance.cache.store(toStore)
  end
  
  def buildKey(appId, contextId, natureId)
    "#{appId}|#{contextId}|#{natureId}"  
  end       
end