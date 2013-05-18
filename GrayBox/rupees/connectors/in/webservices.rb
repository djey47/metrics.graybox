#webservices.rb
#IN connector for webservices

require 'sinatra'

#Q&D example
get '/' do
  'Hello world! This is Metrics Project - GrayBox :)'
end

#IN service : mono-valued
post '/collector/:appId/:contextId/:natureId/:value' do
  response = Response.new
  response.store(params[:appId], params[:contextId], params[:natureId], params[:value])
  204
end



class Response

  def initialize()
  end
  
  def store(appId, contextId, natureId, value)
    puts("POST received! appId: #{appId} - contextId: #{contextId} - natureId: #{natureId} - value: #{value}")

    #Should call collector here...    
  end
  
end