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

        private
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
            weapons.each_with_index do |arma,i|
                if arma.uses == 0
                    weapons.delete_at(i)
                    i = i -1
                end
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

        #def discardShieldBooster(i)
            
        #end

        def discardShieldBoosterInHangar(i)
            if @hangar != nil
                @hangar.removeShieldBooster(i)
            end
        end

        #def discardWeapon(i)
            
        #end

        def discardWeaponInHangar(i)
            if @hangar != nil
                @hangar.removeWeapon(i)
            end
        end

        #def fire
            
        #end

        def ammoPower
            @ammoPower
        end

        attr_reader :hangar

        attr_reader :fuelUnits

        attr_reader :name


        attr_reader :nMedals


        attr_reader :pendingDamage


        attr_reader :shieldBoosters


        attr_reader :shieldPower


        def speed
            return @fuelUnits/@@MAXFUEL
        end

        def getUIversion
            SpaceStationToUI.new(self) #???
        end

        attr_reader :weapons

        def mountShieldBooster(i)
            if @hangar != nil
                @shieldBoosters.push(@hangar.removeShieldBooster(i))
            end
        end

        def mountWeapon(i)
            if @hangar != nil
                @weapons.push(@hangar.removeWeapon(i))
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

        #def protection
            
        #end

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

        #def receiveShot
            
        #end

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

        #def setLoot(loot)
            
        #end

        def pendingDamage=d
            @pendingDamage = d.adjust(@weapons, @shieldBoosters)
        end

        def validState
            if @pendingDamage == nil || @pendingDamage.hasNoEffect
                return true
            else
                return false
            end
        end

        def to_s
            s = "Name: " + name + "\nAmmoPower = " + ammoPower.to_s + "\nShieldPower = " + shieldPower.to_s + "\nFuelUnits: " + fuelUnits.to_s + "\nnMedals: " + nMedals.to_s + "\nPendingDamage:  " + pendingDamage.to_s + "\nHangar: " + hangar.to_s + "\nWeapons: "
            i = 0
            for w in weapons
                i = i + 1
                s = s + "\n" + i.to_s + w.to_s
            end
            
            i = 0
            for sb in shieldBoosters
                i = i + 1
                s = s + "\n" + i.to_s + sb.to_s
            end

            return s
        end

    end #class

end #module