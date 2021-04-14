# encoding: utf-8

module Deepspace
    
class GameUniverse
  @@WIN = 10

  def initialize()
    @dice = Dice.new
    @turns = 0
    @gameState = GameStateController.new

    #Creo que hay que hacer esto aunque no se especifique
    @currentStation = nil
    @currentStationIndex = nil
    @currentEnemy = nil
    @spaceStations = Array.new()

  end

  #Hace falta hacer métodos reader o también writer?
  attr_reader :dice
  attr_reader :turns
  attr_reader :gameState
  attr_reader :currentStation
  attr_reader :currentStationIndex
  attr_reader :currentEnemy
  attr_reader :spaceStations

  private
  def combatGo(station,enemy)
    #Se implementa en la próxima práctica

  end


  def combat()
    #Se implementa en la próxima práctica

  end


  def discardHangar()
    if (self.getState == GameState::INIT or self.getState == GameState::AFTERCOMBAT)
        @currentStation.discardHangar 

  end


  def discardShieldBooster(i)
    if (self.getState == GameState::INIT or self.getState == GameState::AFTERCOMBAT)
        @currentStation.discardShieldBooster(i) 

  end


  def discardShieldBoosterInHangar(i)
    if (self.getState == GameState::INIT or self.getState == GameState::AFTERCOMBAT)
        @currentStation.discardShieldBoosterInHangar(i) 

  end


  def discardWeapon(i)
    if (self.getState == GameState::INIT or self.getState == GameState::AFTERCOMBAT)
        @currentStation.discardWeapon(i) 

  end


  def discardWeaponInHangar(i)
    if (self.getState == GameState::INIT or self.getState == GameState::AFTERCOMBAT)
        @currentStation.discardWeaponInHangar(i) 

  end


  def getState()
    @gameState

  end
  

  def getUIversion()
    GameUniverseToUI.new(self) #??

  end


  def haveAWinner()
    win = False 

    if @currentStation.nMedals == WIN
        win = True 
    
    return win

  end


  def init(names)
    #Se implementa en la próxima práctica

  end

  
  def mountShieldBooster(i)
    if (self.getState == GameState::INIT or self.getState == GameState::AFTERCOMBAT)
        @currentStation.mountShieldBooster(i)

  end


  def mountWeapon(i)
    if (self.getState == GameState::INIT or self.getState == GameState::AFTERCOMBAT)
        @currentStation.mountWeapon(i) 

  end


  def nextTurn()
    #Se implementa en la próxima práctica

  end


  def to_s()
    cadena = "CurrentSpaceStation: " + @currentStation.to_s + "\nCurrentSpaceStationIndex: " + @currentStationIndex.to_s  + "\nTurns: " + @turns.to_s + "\nCurrentEnemy: " + @currentEnemy.to_s + "\nDice: " + @dice.to_s + "\nGameStateController: " + gameState.to_s + "\nArray de SpaceStation: "

    #En caso de que sirva, dejar los demás for que indiquen también índices como este
    @spaceStations.each_with_index do |s,i|
      cadena += ("\nSpaceStation " + (i+1).to_s + ": " + s.to_s)
    
    end

    return cadena
    
  end


end #class

end #module