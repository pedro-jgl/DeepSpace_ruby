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
    state = self.getState.state
    ch = dice.firstShot
    enemyWins = false
    moves = false
    combatResult = CombatResult::NOCOMBAT
        
    if state == GameState::BEFORECOMBAT || state == GameState::INIT
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
          station.pendingDamage(damage)
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


  def combat()
    state = self.getState.state
    
        if state == GameState::BEFORECOMBAT || state == GameState::INIT
          #Así??
          return combat(currentStation, currentEnemy)

        else
          return CombatResult::NOCOMBAT
        end
  end


  def discardHangar()
    if (self.getState.state == GameState::INIT or self.getState.state == GameState::AFTERCOMBAT)
        @currentStation.discardHangar 
    end

  end


  def discardShieldBooster(i)
    if (self.getState.state == GameState::INIT or self.getState.state == GameState::AFTERCOMBAT)
        @currentStation.discardShieldBooster(i) 
    end

  end


  def discardShieldBoosterInHangar(i)
    if (self.getState.state == GameState::INIT or self.getState.state == GameState::AFTERCOMBAT)
        @currentStation.discardShieldBoosterInHangar(i) 
    end

  end


  def discardWeapon(i)
    if (self.getState.state == GameState::INIT or self.getState.state == GameState::AFTERCOMBAT)
        @currentStation.discardWeapon(i) 
    end

  end


  def discardWeaponInHangar(i)
    if (self.getState.state == GameState::INIT or self.getState.state == GameState::AFTERCOMBAT)
        @currentStation.discardWeaponInHangar(i) 
    end

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
    end
    
    return win

  end


  def init(names)
    state = self.getState.state

      if(state == GameState::CANNOTPLAY)
        @dealer = CardDealer.instance
            
        for i in range(names.size)
          @supplies = dealer.nextSuppliesPackage

          station = SpaceStation.new(names.get(i), supplies)


          #Se modifica station despues de añadirla al array??
          @spaceStations.add(station)

          nh = dice.initWithNHangar
          nw = dice.initWithNWeapons
          ns = dice.initWithNShields

          lo = Loot.new(0, nw, ns, nh, 0)

          station.setLoot(lo)
        end

          @currentStationIndex = dice.whoStarts(names.size)
          @currentStation = spaceStations.get(currentStationIndex)
          @currentEnemy = dealer.nextEnemy
          @gameState.next(turns, spaceStations.size)
          
      end

  end

  
  def mountShieldBooster(i)
    if (self.getState == GameState::INIT or self.getState == GameState::AFTERCOMBAT)
        @currentStation.mountShieldBooster(i)
    end

  end


  def mountWeapon(i)
    if (self.getState == GameState::INIT or self.getState == GameState::AFTERCOMBAT)
        @currentStation.mountWeapon(i)
    end

  end


  def nextTurn()
    state = self.getState.state

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