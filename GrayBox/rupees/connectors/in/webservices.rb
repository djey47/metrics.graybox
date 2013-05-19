#webservices.rb
#IN connector for webservices

require 'sinatra'
require 'sinatra/base'

class WebservicesInConnector < Sinatra::Base
  def initialize
    #Required for correct Sinatra init
    super
  end
  
  def store(appId, contextId, natureId, value)
    puts("POST received! appId: #{appId} - contextId: #{contextId} - natureId: #{natureId} - value: #{value}")

    #Should call collector here...    
  end
  
  #Q&D example
  get '/' do
    'Hello world! This is Metrics Project - GrayBox :)
    <br/>
    Currently demonstrating of webservices IN connector'
  end
  
  #IN service : mono-valued
  post '/collector/:appId/:contextId/:natureId/:value' do
    store(params[:appId], params[:contextId], params[:natureId], params[:value])
    204
  end
end