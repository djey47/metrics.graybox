#rediscache.rb
#To address cache, handled by Redis database

require 'redis'

class RedisCache
  
  def initialize
    puts("[RedisCache] Initializing...")    
    
    @redis = Redis.new
  end
  
  #TODO input parameters ??
  def store
    puts("[RedisCache] store was called!")
    
    @redis.set "key1","value1"
  end

  #TODO input parameters ??
  def retrieve
    puts("[RedisCache] retrieve was called!")

    @redis.get "key1"    
  end
end