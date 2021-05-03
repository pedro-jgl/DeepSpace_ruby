# encoding: utf-8

module Deepspace

    class SpaceStation

        @@MAXFUEL = 100
        @@SHIELDLOSSPERUNIT = 0.1

        def initialize(ap, fu, n, nmed, sp, pd, w, sb, h)
            @ammoPower = ap
            @name = n
            @shieldPower = sp 
            @fuelUnits = fu 
            @nMedals = nmed

            @pendingDamage = pd
            @weapons = w
            @shieldBoosters = sb
            @hangar = h
        end

        private
        def assignFuelValue(f)
            if f <= @@MAXFUEL
                @fuelUnits = f
            else
                @fuelUnits = @@MAXFUEL
            end
        end

        #private sigue?
        def cleanPendingDamage
            if @pendingDamage.hasNoEffect
                @pendingDamage = nil
            end
        end

        public
        def self.newSuppliesP(n, supplies)
            new(supplies.ammoPower, supplies.fuelUnits, n, 0, supplies.shieldPower, nil, nil, nil, nil)
        end

        def cleanUpMountedItems
=begin
            for i in 0..@weapons.size
                if (@weapons[i]).uses == 0
                    @weapons.delete_at(i)
                    i = i - 1
                end
            end

            for i in 0..@shieldBoosters.size
                if (@shieldBoosters[i]).uses == 0
                    @shieldBoosters.delete_at(i)
                    i = i - 1
                end
            end 
=end
            if weapons == nil
                @weapons = []
            end

            weapons.each_with_index do |arma,i|
                if arma.uses == 0
                    weapons.delete_at(i)
                    i = i -1
                end
            end

            if shieldBoosters == nil
                @shieldBoosters = []
            end

            shieldBoosters.each_with_index do |escudo,i|
                if escudo.uses == 0
                    shieldBoosters.delete_at(i)
                    i = i -1
                end
            end

        end

        def discardHangar
            @hangar = nil
        end

        def discardShieldBooster(i)
            if shieldBoosters == nil
                @shieldBoosters = []
            end
            
            if i >= 0 && i < shieldBoosters.size
                s = @shieldBoosters.delete_at(i)
                
                if  pendingDamage != nil
                    @pendingDamage.discardShieldBooster
                    
                    self.cleanPendingDamage
                end
            
            end
        end

        def discardShieldBoosterInHangar(i)
            if @hangar != nil
                @hangar.removeShieldBooster(i)
            end
        end

        def discardWeapon(i)
            if weapons == nil
                @weapons = []
            end
            if i >= 0 && i < weapons.size
                w = @weapons.delete_at(i)
                
                if  pendingDamage != nil
                    @pendingDamage.discardWeapon(w)
                    self.cleanPendingDamage
                end
            
            end    
        end

        def discardWeaponInHangar(i)
            if @hangar != nil
                @hangar.removeWeapon(i)
            end
        end

        def fire
           factor = 1

           if weapons != nil
            for w in weapons
                factor *= w.useIt
            end
           end

           return ammoPower*factor
        end

        def ammoPower
            @ammoPower
        end

        attr_reader :hangar

        attr_reader :fuelUnits

        attr_reader :name

        attr_reader :nMedals

        attr_reader :pendingDamage

        attr_reader :shieldPower

        attr_reader :weapons

        attr_reader :shieldBoosters

        def speed
            return @fuelUnits/@@MAXFUEL
        end

        def getUIversion
            if @weapons == nil
                @weapons = []
            end
            if @shieldBoosters == nil
                @shieldBoosters = []
            end
            SpaceStationToUI.new(self) #???
        end

        

        def mountShieldBooster(i)
            if @hangar != nil
                if @shieldBoosters != nil
                    sh = @hangar.removeShieldBooster(i)
                    if sh != nil
                        @shieldBoosters.push(sh)
                    end
                else
                    @shieldBoosters = []
                    sh = @hangar.removeShieldBooster(i)
                    if sh != nil
                        @shieldBoosters.push(sh)
                    end
                end
            end
        end

        def mountWeapon(i)
            if @hangar != nil
                if @weapons != nil
                    w = @hangar.removeWeapon(i)
                    if w != nil
                        @weapons.push(w)
                    end
                else
                    @weapons = []
                    w = @hangar.removeWeapon(i)
                    if w != nil
                        @weapons.push(w)
                    end
                end
            end
        end


        def move
            if @fuelUnits != 0
                @fuelUnits = @fuelUnits - self.speed

                if @fuelUnits < 0
                    @fuelUnits = 0
                end

            end
        end

        def protection
          factor = 1
        
          if shieldBoosters != nil
            for s in shieldBoosters
                    factor *= s.useIt
            end
          end
          
          return shieldPower*factor
                
        end

        def receiveHangar(h)
            if @hangar == nil
                @hangar = h
            end
        end

        def receiveShieldBooster(s)
            if @hangar != nil
                return @hangar.addShieldBooster(s)
            else
                return false
            end
        end

        def receiveShot(shot)
          myProtection = self.protection
            
          if myProtection >= shot
            @shieldPower = @shieldPower - @@SHIELDLOSSPERUNIT*shot
            if @shieldPower < 0.0
                @shieldPower = 0.0
            end
            return ShotResult::RESIST
          else
            @shieldPower = 0.0
            return ShotResult::DONOTRESIST
          end
        end

        def receiveSupplies(s)
            @ammoPower = @ammoPower + s.ammoPower
            @fuelUnits = @fuelUnits + s.fuelUnits
            @shieldPower = @shieldPower + s.shieldPower
        end

        def receiveWeapon(w)
            if @hangar != nil
                return @hangar.addWeapon(w)
            else
                return false
            end
        end

        def setLoot(loot)
          dealer = Deepspace::CardDealer.instance
          h = loot.nHangars

          if h > 0
            hangar = dealer.nextHangar
            receiveHangar(hangar)
          end

          elements = loot.nSupplies
          
          for i in (1..elements)
            sup = dealer.nextSuppliesPackage
            receiveSupplies(sup)
          end

          elements = loot.nWeapons
          
          for i in (1..elements)
            weap = dealer.nextWeapon
            receiveWeapon(weap)
          end
          
          elements = loot.nShields
          
          for i in (1..elements)
            sh = dealer.nextShieldBooster
            receiveShieldBooster(sh)
          end

          medals = loot.nMedals

          @nMedals += medals
        end

        def pendingDamage=d
            @pendingDamage = d.adjust(@weapons, @shieldBoosters)
        end

        def validState
            if @pendingDamage == nil 
                return true
            end
            
            return @pendingDamage.hasNoEffect
        end

        def to_s
            s = "\nName:  "
            if name != nil
                s += name 
            end
            s += "\nammoPower:  "
            if ammoPower != nil
                s += ammoPower.to_s 
            end
            s += "\nShieldPower:  "
            if shieldPower != nil
            s +=  + shieldPower.to_s 
            end
            s += "\nFuelUnits:  "
            if fuelUnits != nil
                s += fuelUnits.to_s
            end
            s += "\nNMedals:  "
            if nMedals != nil
                s +=  nMedals.to_s
            end
            s += "\nPendingDamage:  "
            if pendingDamage != nil
                s += pendingDamage.to_s 
            end
            s += "\nHangar: "
            if hangar != nil
                s += hangar.to_s            
            end
            s += "\nWeapons: "
            i = 0
            if weapons != nil
              for w in weapons
                i = i + 1
                s = s + "\n" + i.to_s + w.to_s
              end
            end
            
            i = 0
            if shieldBoosters != nil
                for sb in shieldBoosters
                    i = i + 1
                    s = s + "\n" + i.to_s + sb.to_s
                end
            end

            return s
        end

    end #class

end #module