#erroritem.rb
#Model: represents base structure for errors

class ErrorItem
  VALUE_NOT_FOUND = '001'
  VALUES_NOT_FOUND = '002'
  
  attr_reader :code
  attr_reader :detail
  
  def initialize(code, detail)
    @code = code 
    @detail = detail
  end
end