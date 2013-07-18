#data.rb
#Data model: represents base structure

class DataItem
  
  attr_reader :key
  attr_reader :value
  
  def initialize(key, value)
    @key = key 
    @value = value
  end
end