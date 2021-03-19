# encoding: utf-8

require_relative 'WeaponType'

module Deepspace

class Weapon 
  
  def initialize(name, type, uses)
    @name = name
    @type = type
    @uses = uses
  end

  def self.newCopy(s)
    new(s.name,s.type,s.uses)
    
  end
  
  #Añadir un consultor de name??
  def name
    return @name
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

  def to_s
    cadena = "Name: " + name + "\nType: " + type().to_s + "\nPower: " + power().to_s + "\nUses: " + uses().to_s;
        
    return cadena;

  end
  
  def getUIVersion
    return WeaponToUI.newCopy(this)
  end

end #classs

end #module