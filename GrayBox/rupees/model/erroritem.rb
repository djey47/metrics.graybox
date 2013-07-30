#erroritem.rb
#Model: represents base structure fo errors

class ErrorItem
  
  attr_reader :code
  attr_reader :detail
  
  def initialize(code, detail)
    @code = code 
    @detail = detail
  end
end