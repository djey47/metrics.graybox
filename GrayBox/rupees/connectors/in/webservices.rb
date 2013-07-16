#webservices.rb
#IN connector for webservices

require_relative './httpserver'

class WebservicesInConnector
  def initialize
    puts("[WebservicesInConnector] Initializing...")    
    
    
  end
  
  def start  
    puts("[WebservicesInConnector] Starting HTTP server...")    

    HttpServer.run!
  end  
end