# encoding: utf-8

require_relative 'WeaponType'

class Weapon 
  
  def initialize(name, type, uses)
    @name = name
    @type = type
    @uses = uses
  end

  def self.newCopy(s)
    new(s.name,s.type,s.uses)
    
  end
  

  def type
    return @type
  end

  def uses
    return @uses
  end

  def power 
    return type.getPower
  end
  
  def useIt
    if (@uses > 0)
        @uses -= 1
        return power
    else
      return 1.0   
    end
    
  end
  
end