# encoding: utf-8

module Deepspace

class Hangar 

  def initialize(maxElements)
    @maxElements = maxElements
    @shieldBoosters = Array.new()
    @weapons = Array.new()

  end


  def self.newCopy(s)
    new(s.maxElements)

  end


  def getUIversion
    if @weapons == nil
      @weapons = []
    end
    if @shieldBoosters == nil
      @shieldBoosters = []
    end
    
    HangarToUI.new(self) #???
  end

  private
  def spaceAvailable
    hayespacio = true
    ocupado = @shieldBoosters.count + @weapons.count

    if ocupado == maxElements
        hayespacio = false
    end

    return hayespacio

  end

  public
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
      @shieldBoosters.push(s)
    else
      aniadido = false
    end

    return aniadido 

  end


  def maxElements
    return @maxElements

  end


  def shieldBoosters
    return @shieldBoosters

  end


  def weapons
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
    out = "El máximo de elementos del Hangar: " + maxElements.to_s + " weapons: " + weapons.to_s + " shields: " + shieldBoosters.to_s
    return out
  end

end #class

end #module