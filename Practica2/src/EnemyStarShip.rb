# encoding: utf-8

module Deepspace

class EnemyStarShip

  def initialize(n,a,s,l,d)
    @ammoPower = a 
    @name = n 
    @shieldPower = s 
    @loot = l 
    @damage = d

  end


  def self.newCopy(e)
    new(e.name,e.ammoPower,e.shieldPower,e.loot,e.damage)

  end


  def getUIversion
    EnemyToUI.new(self) #???

  end


  def fire
    @ammoPower

  end 


  def ammoPower
    @ammoPower

  end 


  def damage 
    @damage

  end 


  def loot 
    @loot

  end 


  def name 
    @name 

  end


  def shieldPower 
    @shieldPower

  end


  def protection 
    @shieldPower

  end 


  def receiveShot(shot)
    resultado = ShotResult::RESIST

    if shieldPower < shot 
        resultado = ShotResult::DONOTRESIST

    end 
    
    return resultado

  end

  def to_s
    s = "Name: " + name + ", AmmoPower = " + ammoPower.to_s + ", ShieldPower = " + shieldPower.to_s + ", loot: " + loot.to_s + ", damage: " + damage.to_s
    return s
  end

end #class  

end #module