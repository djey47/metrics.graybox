#webservices.rb
#IN connector for webservices

require 'sinatra'
require 'sinatra/base'

class HttpServerIn < Sinatra::Base
  def initialize
    #Required for correct Sinatra init
    super
  end

  def store(appId, contextId, natureId, value)
    puts("[HttpServerIn][store] POST received! appId: #{appId} - contextId: #{contextId} - natureId: #{natureId} - value: #{value}")

    MetricsController.instance.collector.add(appId, contextId, natureId, value)
  end
  
  def storeStar(appId, datas)
    puts("[HttpServerIn][store*] POST received! appId: #{appId} - values: #{datas}")
    
    MetricsController.instance.collector.addAll(appId, datas)
  end
  
  #config
  set :environment, :development
  set :server, %w[thin mongrel webrick]    
  set :port, 4567  

  #Q&D example
  get '/' do
    puts("[HttpServerIn] GET received! /")

    [200, 'Hello world! This is Metrics Project - GrayBox :)
    <br/>
    Currently demonstrating of webservices IN connector']
  end
  
  #IN service : mono-valued
  post '/collector/:appId/:contextId/:natureId/:value' do
    store(params[:appId], params[:contextId], params[:natureId], params[:value])
    204
  end

  #IN service : multi-valued
  post '/collector/:appId' do
    req = JSON.parse(request.body.read)    
    storeStar(params[:appId], req["datas"])
    204
  end

end

class WebservicesInConnector
  def initialize
    puts("[WebservicesInConnector] Initializing...")            
  end
  
  def start  
    puts("[WebservicesInConnector] Starting HTTP server...")    

    HttpServerIn.run!
  end  
end