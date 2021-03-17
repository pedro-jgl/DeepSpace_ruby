# encoding: utf-8

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
  

end
