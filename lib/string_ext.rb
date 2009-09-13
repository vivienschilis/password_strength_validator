class String
  
  def is_upcase?
    self.upcase == self
  end
  
  def has_numbers?
    num = self.scan(/\d+/)
    unless num.empty?
      return num.to_s.split("").size
    end
    
    false
  end
  
  def has_chars?
    num = self.scan(/[a-zA-Z]+/)
    unless num.empty?
      return num.to_s.split("").size
    end 
    
    false
  end  
  
  def has_up_down_case?
    return (self.match(/[a-z]+/) != nil and self.match(/[A-Z]+/) != nil)
  end
  
  def has_special_chars?
    num = self.scan(/\W+/)
    unless num.empty?
      return num.to_s.split("").size
    end
    
    false
  end
 
  def has_only_chars?
    self.match(/^[a-zA-Z]+$/) != nil
  end 

  def has_only_numbers?
    self.match(/^\d+$/) != nil
  end  

  def repeated_chars(level=1)
    repeat_hash={}
    (0..self.size).each do |i|
      token = self[i..(i+level-1)]
      repeat_hash[token] ||= 0
      repeat_hash[token] += 1
    end
    
    repeat_hash.select{|k,v| v > 1}.size     
  end
  
end


