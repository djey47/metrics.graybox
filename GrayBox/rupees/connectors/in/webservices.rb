#webservices.rb
#IN connector for webservices

require 'sinatra'
require 'sinatra/base'

class HttpServer < Sinatra::Base
  def initialize
    #Required for correct Sinatra init
    super
  end

  def store(appId, contextId, natureId, value)
    puts("[HttpServer] POST received! appId: #{appId} - contextId: #{contextId} - natureId: #{natureId} - value: #{value}")

    MetricsController.instance.collector.add(appId, contextId, natureId, value)
  end
  
  #Q&D example
  get '/' do
    puts("[HttpServer] GET received! /")

    [200, 'Hello world! This is Metrics Project - GrayBox :)
    <br/>
    Currently demonstrating of webservices IN connector']
  end
  
  #IN service : mono-valued
  post '/collector/:appId/:contextId/:natureId/:value' do
    store(params[:appId], params[:contextId], params[:natureId], params[:value])
    204
  end

end

class WebservicesInConnector
  def initialize
    puts("[WebservicesInConnector] Initializing...")    
    
    
  end
  
  def start  
    puts("[WebservicesInConnector] Starting HTTP server...")    

    HttpServer.run!
  end  
end