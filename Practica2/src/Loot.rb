# encoding: utf-8

module Deepspace

class Loot
  
  def initialize(nSup, nWeap, nShie, nHang, nMed)
    @nSupplies = nSup
    @nWeapons = nWeap
    @nShields = nShie
    @nHangars = nHang
    @nMedals = nMed
    
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
  
  def to_s
    out = "NSupplies: " + nSupplies().to_s + "\n NShields: " + nShields().to_s +  "\nNHangars: " + nHangars().to_s + "\nNMedals: " + nMedals().to_s

  end

  def getUIVersion
    return LootToUI.newCopy(this)
  end
end #class

end #module
