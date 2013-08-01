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
    puts("[HttpServerOut][retrieve] GET received! appId: #{appId} - contextId: #{contextId} - natureId: #{natureId}")

    MetricsController.instance.server.get(appId, contextId, natureId)
  end
  
  def retrieveStar(appId)
    puts("[HttpServerOut][retrieve*] GET received! appId: #{appId}")

    MetricsController.instance.server.getAll(appId)
  end
  
  def buildDataStructure(data)
    { :key => data.key, :value => data.value }   
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
    begin      
      result = retrieve(params[:appId], params[:contextId], params[:natureId])
      content_type :json      
      [200, buildDataStructure(result).to_json]      
    rescue NoValueException
      error = { :code => ErrorItem::VALUE_NOT_FOUND, :detail => "#{params[:appId]}|#{params[:contextId]}|#{params[:natureId]}"}
      content_type :json      
      [404, error.to_json]      
    end
  end

  #OUT service : multi-valued
  get '/server/:appId' do
    begin      
      results = retrieveStar(params[:appId])
      content_type :json         
      toReturn = []
      results.each { |result| toReturn << buildDataStructure(result) }                   
      [200, { :datas => toReturn}.to_json]
    rescue NoValueException
      error = { :code => ErrorItem::VALUE_NOT_FOUND, :detail => "#{params[:appId]}|<any>|<any>"}
      content_type :json      
      [404, error.to_json]      
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