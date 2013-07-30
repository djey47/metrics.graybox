#erroritem.rb
#Model: represents base structure fo errors

class ErrorItem
  VALUE_NOT_FOUND = '001'
  
  attr_reader :code
  attr_reader :detail
  
  def initialize(code, detail)
    @code = code 
    @detail = detail
  end
end