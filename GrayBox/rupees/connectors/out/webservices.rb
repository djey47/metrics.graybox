#webservices.rb
#OUT connector for webservices

require 'sinatra'
require 'sinatra/base'
require 'json'
require_relative '../../model/erroritem'
require_relative '../../model/exceptions/novalueexception'

class HttpServerOut < Sinatra::Base
  def initialize
    #Required for correct Sinatra init
    super
  end

  def retrieve(appId, contextId, natureId)
    puts("[HttpServerOut][retrieve] GET, appId: #{appId} - contextId: #{contextId} - natureId: #{natureId}")

    MetricsController.instance.server.get(appId, contextId, natureId)
  end
  
  def retrieveStar(appId)
    puts("[HttpServerOut][retrieve*] GET, appId: #{appId}")

    MetricsController.instance.server.getAll(appId)
  end
  
  def buildDataStructure(data)
    { :key => data.key, :value => data.value }   
  end
  
  # Encapsulates with jsonp when necessary
  def handleJsonResult(params, json)
    if (params[:jsonp_callback]) 
      "#{params[:jsonp_callback]}(#{json})"
    else
      json 
    end 
  end

  #config
  set :environment, :development
  set :server, %w[thin mongrel webrick]    
  set :port, 4568  

  #Q&D example
  get '/' do
    puts("[HttpServerOut] GET /")

    [200, 'Hello world! This is Metrics Project - GrayBox :)
    <br/>
    Currently demonstrating of webservices OUT connector']
  end
  
  #OUT service : mono-valued
  get '/server/:appId/:contextId/:natureId' do
    begin      
      result = retrieve(params[:appId], params[:contextId], params[:natureId])
      json = buildDataStructure(result).to_json
      content_type :json      
      [200, handleJsonResult(params, json) ]      
    rescue NoValueException
      error = { :code => ErrorItem::VALUE_NOT_FOUND, :detail => "#{params[:appId]}|#{params[:contextId]}|#{params[:natureId]}"}
      json = error.to_json
      content_type :json      
      [404, handleJsonResult(params, json)]      
    end
  end

  #OUT service : multi-valued
  get '/server/:appId' do
    begin      
      results = retrieveStar(params[:appId])
      toReturn = []
      results.each { |result| toReturn << buildDataStructure(result) } 
      json = { :datas => toReturn}.to_json                  
      content_type :json         
      [200, handleJsonResult(params, json)]
    rescue NoValueException
      error = { :code => ErrorItem::VALUES_NOT_FOUND, :detail => "#{params[:appId]}|<any>|<any>"}
      json = error.to_json      
      content_type :json      
      [404, handleJsonResult(params, json)]      
    end      
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