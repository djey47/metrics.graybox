#controller.rb
#Metrics Controller

require_relative '../cache/rediscache'
require_relative '../collector/collector'
require_relative '../server/server'
require_relative '../connectors/in/webservices'
require_relative '../connectors/out/webservices'

require 'singleton'

class MetricsController 
  include Singleton
  
  attr_accessor :cache
  attr_accessor :collector
  attr_accessor :server
  attr_accessor :wsInConnector
  attr_accessor :wsOutConnector
      
  def initialize               
    @cache = RedisCache.new

    @collector = Collector.new 

    @server = Server.new
        
    @wsInConnector = WebservicesInConnector.new
    
    @wsOutConnector = WebservicesOutConnector.new
    
    # Should instantiate all enabled aggregators
    
    # Should instantiate all enabled formatters
  end
    
  def run
    allThreads = []

    # Webservices IN
    allThreads << Thread.new {
      puts("[MetricsController] Starting WebservicesInConnector...")
    
      @wsInConnector.start
    }
    
    # To prevent misconfiguring of HTTP servers
    sleep 0.25
    
    # Webservices OUT
    allThreads << Thread.new {      
      puts("[MetricsController] Starting WebservicesOutConnector...")
    
      @wsOutConnector.start
    }    

    # Waiting for all threads to terminate
    allThreads.each { |thr| thr.join }
  end
end

# Boot
puts("[MetricsController] Booting Metrics controller...")

MetricsController.instance.run

puts("[MetricsController] Exiting Metrics controller...")
