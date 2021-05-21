# encoding: utf-8
require_relative 'LootToUI'
module Deepspace

class Loot
  
  def initialize(nSup, nWeap, nShie, nHang, nMed, ef=false, city=false)
    @nSupplies = nSup
    @nWeapons = nWeap
    @nShields = nShie
    @nHangars = nHang
    @nMedals = nMed
    @getEfficient = ef
    @spaceCity = city
    
  end

  def nSupplies
    return @nSupplies
  end
  
  def nWeapons
    return @nWeapons
  end
  
  def nShields
    return @nShields
  end

  def nHangars
    return @nHangars
  end   
  
  def nMedals
    return @nMedals  
  end

  def getEfficient
    return @getEfficient
  end

  def spaceCity
    return @spaceCity
  end
  
  def to_s
    out = "NSupplies: " + nSupplies().to_s + "\n NShields: " + nShields().to_s +  "\nNHangars: " + nHangars().to_s + "\nNMedals: " + nMedals().to_s
    out += ("\ngetEfficient: " + getEfficient.to_s + "\nspaceCity: " + spaceCity.to_s)
    return out
  end

  def getUIversion
    return LootToUI.new(self)
  end
  
end #class

end #module