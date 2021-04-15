# encoding: utf-8

module Deepspace

    class Damage 
      #Así se crea una constante estática?
      @@NO_USE = -1 

      def initialize(w, s, wl)
        @nShields = s
        @nWeapons = w
        @weapons = wl
      end

      def self.newCopy(d)
        new(d.nWeapons, d.nShields, d.weapons)
      end
      
      def nWeapons
        return @nWeapons
      end

      def nShields
        return @nShields          
      end

      def weapons
        return @weapons
      end
      
      def self.newNumericWeapons(w, s)
        new(w, s, nil)
      end

      def self.newSpecificWeapons(wl, s)
        new(@@NO_USE, s, wl)
      end

      def discardWeapon(w)
        if @weapons != nil
    
          @weapons.each do |weap|
            #solucionar coincidencias, por ahora borra todos los que coincidan
            #usar arrayContainsType?¿
            if weap == w
              @weapons.delete(w)
            end
          end

        elsif @nWeapons != 0
          @nWeapons = @nWeapons - 1
        end
        
      end

      def discardShieldBooster
        if @nShields > 0
          @nShields = @nShields - 1
        end
      end

      def hasNoEffect
        noeffect = false
        if @nShields == 0 && ( (@weapons == nil && @nWeapons == 0) || (@nWeapons == NO_USE && @weapons.length == 0) )
          noeffect = true
        end

        return noeffect
      end
    
      #bien?¿
      def arrayContainsType(w, t)
        count = 0
        
        w.each do |weap|
          if weap == t 
            return count  
          else
            count = count + 1
          end
        end

        return -1
      end

      #Modificar a como está hecha en java (Hay que devolver un damage nuevo y modificar algunas condicionales)
      def adjust(w, s)
        
        for i in 1..s.length
          self.discardShieldBooster
        end

        w.each do |weap|
          self.discardWeapon(weap) 
        end

      end

      def to_s
        out = "NShields: " + nShields.to_s + "\nNWeapons: " + nWeapons.to_s + "\nWeapons:\n"

        i = 0
            for w in weapons
                i = i + 1
                out = out + "\n" + i + w.to_s
            end
        
        return out
      end

      def getUIVersion
        DamageToUI.new(self) #???
      end

    end

end    