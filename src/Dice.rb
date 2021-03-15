# encoding: utf-8

module Basico
    class Dice 
    def initialize
        @NHANGARSPROB  = 0.25
        @NSHIELDSPROB  = 0.25
        @NWEAPONSPROB  = 0.33
        @FIRSTSHOTPROB = 0.5
        @generator     = nil 
    end    
    
    def initWithNHangars
        @generator = rand
        if @generator <= @NHANGARSPROB
            return 0
        else
            return 1
        end
    end

    def initWithNWeapons
        @generator = rand
        prob_caso1 = 1 - 2 * @NWEAPONSPROB
        prob_caso2 = prob_caso1 + ( (1 - prob_caso1) / 2 )

        if @generator <= prob_caso1
            return 3
            
        elsif @generator <= prob_caso2
            return 1
            
        else
            return 2
            
        end
        
    end
    
    def initWithShields
        @generator = rand

        if @generator <= @NSHIELDSPROB
            return 0
        else
            return 1
        end
    end

    def whoStarts(nPlayers)
        @generator = rand(nPlayers)
        @generator += 1
        return @generator

    end

    def firstShot
        @generator = rand
        
        if @generator <= @FIRSTSHOTPROB
        return GameCharacter::SPACESTATION
        else
        return GameCharacter::ENEMYSTARSHIP
        end
    end

    def spaceStationMoves(speed)
        @generator = rand
        
        if @generator <= speed
            return True
        else
            return False
        end

    end

    end
end