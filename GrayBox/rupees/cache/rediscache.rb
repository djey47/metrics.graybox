#rediscache.rb
#To address cache, handled by Redis database

require 'redis'

require_relative '../model/dataitem'

class RedisCache
  
  def initialize
    puts("[RedisCache] Initializing...")    
    
    @redis = Redis.new
  end
  
  def store(datas)
    puts("[RedisCache][store] Datas count: #{datas.length}")
    
    @redis.multi do
      datas.each { |data| @redis.set(data.key, data.value) }
    end
  end

  def retrieve(keys)
    puts("[RedisCache][retrieve] Keys count: #{keys.length}")

    results = []
    @redis.multi do
      keys.each { |key| results << @redis.get(key) }
    end
    
    i = -1   
    datas = []    
    datas = results.collect do |future|       
      i += 1
      DataItem.new(keys[i], future.value)
    end
    
    puts("[RedisCache][retrieve] Result: #{datas}")
    
    datas
  end
  
  def retrieveByAppId(appId)
    puts("[RedisCache][retrieveByAppId] appId: #{appId}")

    keys = @redis.keys("#{appId}|*|*")
    datas = retrieve(keys)
    
    puts("[RedisCache][retrieveByAppId] Keys: #{keys}")
    puts("[RedisCache][retrieveByAppId] Result: #{datas}")

    datas  
  end
  
end