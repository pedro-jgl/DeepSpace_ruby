# encoding: utf-8

module Deepspace

class SuppliesPackage

  def initialize(amP, flUn, shP)
    @ammoPower   = amP
    @fuelUnits   = flUn
    @shieldPower = shP
  end

  def self.newCopy(s)
    new(s.ammoPower,s.fuelUnits,s.shieldPower)
  end

  def ammoPower
    return @ammoPower
  end

  def fuelUnits
      return @fuelUnits
  end
  
  def shieldPower
    return @shieldPower
  end

  def method_name
    out = "AmmoPower: " + ammoPower().to_s + "\nFuelUnits: " + fuelUnits().to_s + "\nShieldPower: " + shieldPower().to_s 

  end

end #class

end #module