# encoding: utf-8

Directorio = "./"
Dir[Directorio+"*"].each do |file|
  file = file[Directorio.size,file.size] 
  file = file[0,file.size-3]            

  if file != "PlayWithUI" && file != "Controller" && file != "TextMainView" && file != "GameUniverse" && file != "TestP3"
    require_relative file
  end
end

module Deepspace
    
class GameUniverse
  @@WIN = 10

  def initialize
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
    estado = self.state.state
    ch = dice.firstShot
    enemyWins = false
    moves = false
    combatResult = CombatResult::NOCOMBAT
        
    if estado == GameState::BEFORECOMBAT || estado == GameState::INIT
      if ch==GameCharacter::ENEMYSTARSHIP
        fire = enemy.fire
        result = station.receiveShot(fire)
    
        if result == ShotResult::RESIST
          fire = station.fire
          result = enemy.receiveShot(fire)
    
          enemyWins = (result == ShotResult::RESIST)
    
        else
          enemyWins = true
        end

      else
        fire = station.fire
        result = enemy.receiveShot(fire)
        enemyWins = (result == ShotResult::RESIST)
      end

      if enemyWins
        s = station.speed
        moves = dice.spaceStationMoves(s)
              
        if !moves
          damage = enemy.damage
          station.pendingDamage=damage
          combatResult = CombatResult::ENEMYWINS
        else
        station.move
        combatResult = CombatResult::STATIONESCAPES
        end

      else
        aLoot = enemy.loot
        station.setLoot(aLoot)
        combatResult = CombatResult::STATIONWINS
      
        gameState.next(self.turns, self.spaceStations.size)
      end
    else
    combatResult = CombatResult::NOCOMBAT
    end
    
    return combatResult;
  end

  public
  def combat()
    estado = self.state.state
    
        if estado == GameState::BEFORECOMBAT || estado == GameState::INIT
          #Así??
          return combatGo(currentStation, currentEnemy)

        else
          return CombatResult::NOCOMBAT
        end
  end


  def discardHangar()
    if (self.state.state == GameState::INIT or self.state.state == GameState::AFTERCOMBAT)
        @currentStation.discardHangar 
    end

  end


  def discardShieldBooster(i)
    if (self.state.state == GameState::INIT or self.state.state == GameState::AFTERCOMBAT)
        @currentStation.discardShieldBooster(i) 
    end

  end


  def discardShieldBoosterInHangar(i)
    if (self.state.state == GameState::INIT or self.state.state == GameState::AFTERCOMBAT)
        @currentStation.discardShieldBoosterInHangar(i) 
    end

  end


  def discardWeapon(i)
    if (self.state.state == GameState::INIT or self.state.state == GameState::AFTERCOMBAT)
        @currentStation.discardWeapon(i) 
    end

  end


  def discardWeaponInHangar(i)
    if (self.state.state == GameState::INIT or self.state.state == GameState::AFTERCOMBAT)
        @currentStation.discardWeaponInHangar(i) 
    end

  end


  def state()
    @gameState

  end
  

  def getUIversion()
    GameUniverseToUI.new(currentStation, currentEnemy) #??

  end


  def haveAWinner()
    win = False 

    if @currentStation.nMedals == WIN
        win = True 
    end
    
    return win

  end


  def init(names)
    estado = self.state.state

      if(estado == GameState::CANNOTPLAY)
        @dealer = CardDealer.instance
            
        for i in 0..names.size
          @supplies = @dealer.nextSuppliesPackage

          station = SpaceStation.newSuppliesP(names[i], @supplies)

          nh = dice.initWithNHangars
          nw = dice.initWithNWeapons
          ns = dice.initWithNShields

          lo = Loot.new(0, nw, ns, nh, 0)

          station.setLoot(lo)
          
          @spaceStations.push(station)

        end

          @currentStationIndex = dice.whoStarts(names.size)
          @currentStation = spaceStations[currentStationIndex]
          @currentEnemy = @dealer.nextEnemy
          @gameState.next(turns, spaceStations.size)
          
      end

  end

  
  def mountShieldBooster(i)
    if (self.state == GameState::INIT or self.state == GameState::AFTERCOMBAT)
        @currentStation.mountShieldBooster(i)
    end

  end


  def mountWeapon(i)
    if (self.state == GameState::INIT or self.state == GameState::AFTERCOMBAT)
        @currentStation.mountWeapon(i)
    end

  end


  def nextTurn()
    state = self.state.state

      if state == GameState::AFTERCOMBAT
        stationState = currentStation.validState

        if stationState
          @currentStationIndex = (currentStationIndex + 1)%spaceStations.size
          @turns += 1

          @currentStation = spaceStations[currentStationIndex]
          @currentStation.cleanUpMountedItems

          dealer = CardDealer.instance

          @currentEnemy = dealer.nextEnemy

          @gameState.next(turns, spaceStations.size)

          return true
          
        else
          return false
          
        end

            
      else
        return false
        
      end

  end

  
  def to_s
    cadena = "CurrentSpaceStation: " + @currentStation.to_s + "\nCurrentSpaceStationIndex: " + @currentStationIndex.to_s  + "\nTurns: " + @turns.to_s + "\nCurrentEnemy: " + @currentEnemy.to_s + "\nDice: " + @dice.to_s + "\nGameStateController: " + gameState.to_s + "\nArray de SpaceStation: "

    @spaceStations.each_with_index do |s,i|
      cadena += ("\nSpaceStation " + (i+1).to_s + ": " + s.to_s)
    
    end

    return cadena
    
  end


end #class

end #module