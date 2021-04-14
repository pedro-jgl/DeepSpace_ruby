# encoding: utf-8

module Deepspace

class Hangar 

  def initialize(maxElements)
    @maxElements = maxElements
    @shieldBoosters = Array.new()
    @weapons = Array.new()

  end


  def self.newCopy(s)
    new(s.getMaxElements)

  end


  def getUIVersion
    HangarToUI.new(self) #???
  end


  def spaceAvailable
    hayespacio = true
    ocupado = @shieldBoosters.count + @weapons.count

    if ocupado == getMaxElements
        hayespacio = false
    end

    return hayespacio

  end


  def addWeapon(w)
    aniadido = true

    if spaceAvailable
      @weapons.push(w)
    else
      aniadido = false
    end

    return aniadido 

  end 


  def addShieldBooster(s)
    aniadido = true

    if spaceAvailable
      @shieldBoosters.push(w)
    else
      aniadido = false
    end

    return aniadido 

  end


  def getMaxElements
    return @maxElements

  end


  def getShieldBoosters
    return @shieldBoosters

  end


  def getWeapons
    return @weapons

  end


  def removeShieldBooster(s)
    #Esto automáticamente devuelve el escudo borrado
    #(nil en caso de que s > número máximo de escudos)
    @shieldBoosters.delete_at(s)

  end


  def removeWeapon(w)
    @weapons.delete_at(w)

  end

  def to_s
    out = "El máximo de elementos del Hangar: " + getMaxElements.to_s + " weapons: " + getWeapons.to_s + " shields: " + getShieldBoosters.to_s
    return out
  end

end #class

end #module