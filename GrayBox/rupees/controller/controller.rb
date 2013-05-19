#controller.rb
#Metrix Controller

require_relative '../connectors/in/webservices'

class MetrixController
 
  def initialize
    
    # Should instantiate collector
    
    # Should instantiate server

    # Should instantiate all enabled IN connectors
    
    # Should instantiate all enabled OUT connectors
    
    # Should instantiate all enabled aggregators
    
    # Should instantiate all enabled formatters
    
  end
    
  def run
    # Webservices IN
    # TODO in a new thread
    puts("Starting WebservicesInConnector...")
    WebservicesInConnector.run!
    puts("WebservicesInConnector started.")    
    
    # Main loop here ...
  end
end

# Boot
puts("Booting Metrix controller...")
controller = MetrixController.new
controller.run
puts("Exiting Metrix controller...")
