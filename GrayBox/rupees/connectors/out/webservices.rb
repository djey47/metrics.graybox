#webservices.rb
#OUT connector for webservices

require 'sinatra'
require 'sinatra/base'

class HttpServer < Sinatra::Base
  def initialize
    #Required for correct Sinatra init
    super
  end

  def retrieve(appId, contextId, natureId)
    puts("[HttpServer][retrieve] GET received! appId: #{appId} - contextId: #{contextId} - natureId: #{natureId}")

    MetricsController.instance.server.get(appId, contextId, natureId)
  end
  
  def retrieveStar(appId)
    puts("[HttpServer][retrieve*] GET received! appId: #{appId}")

    MetricsController.instance.server.getAll(appId)
  end

  #Q&D example
  get '/' do
    puts("[HttpServer] GET received! /")

    [200, 'Hello world! This is Metrics Project - GrayBox :)
    <br/>
    Currently demonstrating of webservices OUT connector']
  end
  
  #OUT service : mono-valued
  get '/server/:appId/:contextId/:natureId' do
    retrieve(params[:appId], params[:contextId], params[:natureId])
    200
  end

  #OUT service : multi-valued
  get '/server/:appId' do
    retrieveStar(params[:appId])
    200
  end

end

class WebservicesOutConnector
  def initialize
    puts("[WebservicesOutConnector] Initializing...")            
  end
  
  def start  
    puts("[WebservicesOutConnector] Starting HTTP server...")    

    HttpServer.run!
  end  
end