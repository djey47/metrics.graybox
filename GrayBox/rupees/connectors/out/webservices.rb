#webservices.rb
#OUT connector for webservices

require 'sinatra'
require 'sinatra/base'

class HttpServerOut < Sinatra::Base
  def initialize
    #Required for correct Sinatra init
    super
  end

  def retrieve(appId, contextId, natureId)
    puts("[HttpServerOut][retrieve] GET received! appId: #{appId} - contextId: #{contextId} - natureId: #{natureId}")

    MetricsController.instance.server.get(appId, contextId, natureId).to_json
  end
  
  def retrieveStar(appId)
    puts("[HttpServerOut][retrieve*] GET received! appId: #{appId}")

    MetricsController.instance.server.getAll(appId).to_json
  end

  #config
  set :environment, :development
  set :server, %w[thin mongrel webrick]    
  set :port, 4568  

  #Q&D example
  get '/' do
    puts("[HttpServerOut] GET received! /")

    [200, 'Hello world! This is Metrics Project - GrayBox :)
    <br/>
    Currently demonstrating of webservices OUT connector']
  end
  
  #OUT service : mono-valued
  get '/server/:appId/:contextId/:natureId' do
    result = retrieve(params[:appId], params[:contextId], params[:natureId])
    [200, result]
  end

  #OUT service : multi-valued
  get '/server/:appId' do
    result = retrieveStar(params[:appId])
    [200, result]
  end

end

class WebservicesOutConnector
  def initialize
    puts("[WebservicesOutConnector] Initializing...")            
  end
  
  def start  
    puts("[WebservicesOutConnector] Starting HTTP server...")    

    HttpServerOut.run!
  end  
end