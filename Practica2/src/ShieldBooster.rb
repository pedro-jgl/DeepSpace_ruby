# encoding: utf-8

module Deepspace

class ShieldBooster
    
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
  def name
    return @name
  end
  
  def useIt
    if (@uses > 0)
      @uses -= 1
      return @uses
    else
      return 1.0   
    end
  end

  def to_s
    cadena = "Name: " + name() + "\nBoost: " + boost().to_s + "\nUses: " + uses().to_s;
        
    return cadena;
  end

  def getUIVersion
    return ShieldToUI.newCopy(this)
  end
  
end #class
    
end #module