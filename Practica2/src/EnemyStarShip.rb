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


  def getUIversion()
    

  end


end #class  

end #module