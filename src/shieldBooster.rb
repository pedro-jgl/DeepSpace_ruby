# encoding: utf-8

class shieldBooster
    
  def initialize(name, boost, uses)
      @name = name
      @boost = boost
      @uses = uses
  end
  
  def self.newCopy(s)
    new(s.name,s.boost,s.uses)
  end
  
  def boost
    return @boost
  end

  def uses
      return @uses
  end

  #Añadir consultor de name??
  
  def useIt
    if (@uses > 0)
        @uses -= 1
        return @uses
    else
      return 1.0   
    end
    
  end


end
    