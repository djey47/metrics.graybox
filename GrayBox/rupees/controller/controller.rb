#controller.rb
#Metrics Controller

require 'singleton'
require_relative '../connectors/in/webservices'
require_relative '../collector/collector'

class MetricsController 
  
  include Singleton
  
  attr_accessor :collector  
 
  def initialize    
    @collector = Collector.new 
    
    # Should instantiate cache
    
    # Should instantiate server

    # Should instantiate all enabled IN connectors
    
    # Should instantiate all enabled OUT connectors
    
    # Should instantiate all enabled aggregators
    
    # Should instantiate all enabled formatters
    
  end
    
  def run
    # Webservices IN
    # TODO in a new thread
    puts("[MetricsController] Starting WebservicesInConnector...")
    WebservicesInConnector.run!
    puts("[MetricsController] WebservicesInConnector started.")    
    
    # Main loop here ...
  end
end

# Boot
puts("[MetricsController] Booting Metrics controller...")

MetricsController.instance.run

puts("[MetricsController] Exiting Metrics controller...")
