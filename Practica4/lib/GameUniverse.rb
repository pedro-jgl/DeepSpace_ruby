# encoding: utf-8
require_relative 'GameUniverseToUI'
require_relative 'SpaceStation'
require_relative 'GameStateController'
require_relative 'EnemyStarShip'
require_relative 'Dice'
require_relative 'ShotResult'
require_relative 'CombatResult'
require_relative 'GameCharacter'
require_relative 'CardDealer'
require_relative 'Transformation'
require_relative 'PowerEfficientSpaceStation'
require_relative 'BetaPowerEfficientSpaceStation'
require_relative 'SpaceCity'

module Deepspace
    
  class GameUniverse
    @@WIN = 10

    def initialize
      @currentStationIndex = -1
      @turns = 0
      @gameState = GameStateController.new
      @currentEnemy
      @dice = Dice.new
      @currentStation = 0
      @spaceStations = Array.new
      @haveSpaceCity = false

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
      ch = dice.firstShot
      enemyWins = false
      moves = false
      combatResult = CombatResult::NOCOMBAT
      if ch == GameCharacter::ENEMYSTARSHIP
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
          station.setPendingDamage(damage)
          combatResult = CombatResult::ENEMYWINS
        else
          station.move
          combatResult = CombatResult::STATIONESCAPES
        end
      else
        aLoot = enemy.loot
        transformacion = station.setLoot(aLoot)
        combatResult = CombatResult::STATIONWINS
        
        if transformacion == Transformation::GETEFFICIENT
          makeStationEfficient
          
          combatResult = CombatResult::STATIONWINSANDCONVERTS

        elsif transformacion == Transformation::SPACECITY
          if !@haveSpaceCity
            combatResult = CombatResult::STATIONWINSANDCONVERTS
          end 

          createSpaceCity    
        end
      end
      
      gameState.next(self.turns, self.spaceStations.size)
      
      return combatResult
    end

    public
    def combat()
      estado = self.state
      
          if estado == GameState::BEFORECOMBAT || estado == GameState::INIT
            return combatGo(currentStation, currentEnemy)

          else
            return CombatResult::NOCOMBAT
          end
    end


    def discardHangar()
      if (self.state == GameState::INIT or self.state == GameState::AFTERCOMBAT)
          @currentStation.discardHangar 
      end

    end


    def discardShieldBooster(i)
      if (self.state == GameState::INIT or self.state == GameState::AFTERCOMBAT)
          @currentStation.discardShieldBooster(i) 
      end

    end


    def discardShieldBoosterInHangar(i)
      if (self.state == GameState::INIT or self.state == GameState::AFTERCOMBAT)
          @currentStation.discardShieldBoosterInHangar(i) 
      end

    end


    def discardWeapon(i)
      if (self.state == GameState::INIT or self.state == GameState::AFTERCOMBAT)
          @currentStation.discardWeapon(i) 
      end

    end


    def discardWeaponInHangar(i)
      if (self.state == GameState::INIT or self.state == GameState::AFTERCOMBAT)
          @currentStation.discardWeaponInHangar(i) 
      end

    end

    def state()
      @gameState.state

    end
    
    def gameState
      @gameState
    end

    def getUIversion()
      if currentStation == nil
        sup = SuppliesPackage.new(0,0,0)
        @currentStation = SpaceStation.new("",sup)
      end
      if currentEnemy == nil
        sup = SuppliesPackage.new(0,0,0)
        @currentEnemy = SpaceStation.new("",sup)

      end
      GameUniverseToUI.new(currentStation, currentEnemy) #??

    end


    def haveAWinner()
      win = false 

      if @currentStation.nMedals >= @@WIN
          win = true 
      end
      
      return win

    end


    def init(names)
      estado = self.state
      size = names.length

        if estado == GameState::CANNOTPLAY
          dealer = CardDealer.instance
          for i in (0..size-1)
            @supplies = dealer.nextSuppliesPackage

            station = SpaceStation.new(names[i], @supplies)

            nh = dice.initWithNHangars
            nw = dice.initWithNWeapons
            ns = dice.initWithNShields

            lo = Loot.new(0, nw, ns, nh, 0)

            station.setLoot(lo)
            
            if @spaceStations == nil
              @spaceStations = []
            end

            @spaceStations.push(station)

          end

            @currentStationIndex = dice.whoStarts(size)
            @currentStation = spaceStations[@currentStationIndex]
            @currentEnemy = dealer.nextEnemy
            @gameState.next(turns, size)
            
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
      state = @gameState.state
        if state == Deepspace::GameState::AFTERCOMBAT
          stationState = @currentStation.validState
          if(stationState)
            @currentStationIndex=(@currentStationIndex+1) % @spaceStations.length
            @currentStation=@spaceStations[@currentStationIndex]
            @turns+=1
            @currentStation.cleanUpMountedItems
            dealer = CardDealer.instance
            @currentEnemy = dealer.nextEnemy
            @gameState.next(@turns, @spaceStations.length)
            
            return true
          end
          return false
        end
        return false
    end

    
    def to_s
      cadena = "CurrentSpaceStation: " + @currentStation.to_s + "\nCurrentSpaceStationIndex: " + @currentStationIndex.to_s  + "\nTurns: " + @turns.to_s + "\nCurrentEnemy: " + @currentEnemy.to_s + "\nDice: " + @dice.to_s + "\nGameStateController: " + gameState.to_s + "\nArray de SpaceStation: "

      @spaceStations.each_with_index do |s,i|
        cadena += ("\nSpaceStation " + (i+1).to_s + ": " + s.to_s)
      
      end

      return cadena
      
    end
    
    def makeStationEfficient
      if @dice.extraEfficiency
        @currentStation = BetaPowerEfficientSpaceStation.new(@currentStation)
      else
        @currentStation = PowerEfficientSpaceStation.new(@currentStation)
      end
      @spaceStations.delete_at(@currentStationIndex)
      @spaceStations[@currentStationIndex] = @currentStation
    end

    
    def createSpaceCity
      if !@haveSpaceCity
        @currentStation = SpaceCity.new(@currentStation, @spaceStations)
        @haveSpaceCity = true

        @spaceStations.delete_at(@currentStationIndex)
        @spaceStations[@currentStationIndex] = @currentStation
      end
           
    end

    
  end #class

end #module