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
    puts("[RedisCache] store was called! Datas count: #{datas.length}")
    
    @redis.multi do
      datas.each { |data| @redis.set(data.key, data.value) }
    end
  end

  def retrieve(keys)
    puts("[RedisCache] retrieve was called! Keys count: #{keys.length}")

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
    
    puts("[RedisCache] retrieve result: #{datas}")
    
    datas
  end
end