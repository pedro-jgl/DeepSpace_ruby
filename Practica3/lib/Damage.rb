# encoding: utf-8
require_relative 'DamageToUI'

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

      attr_accessor :nWeapons
      
      attr_accessor :nShields

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
        if(@weapons == nil && @nWeapons > 0)
          @nWeapons-=1	
        else
          index = @weapons.index(w.type)
          if index != nil
            @weapons.delete_at(index)
          end
        end
      end

      def discardShieldBooster
        if @nShields > 0
          @nShields = @nShields - 1
        end
      end

      def hasNoEffect
        noeffect = false
        if @nShields == 0 && ( (@weapons == nil && @nWeapons == 0) || (@nWeapons == @@NO_USE && @weapons.length == 0) )
          noeffect = true
        end

        return noeffect
      end

      private
      def arrayContainsType(w,t)
        index = -1
        wt = Array.new    #array de los types de w

        if w != nil
          w.each do |weap|
            wt.append(weap.type)
          end

          index = wt.index(t)   #Si no lo encuentra devuelve nil
        end

        if index == nil
          index = -1
        end

        return index
      end


      public
      def adjust(w, s)
        danio = Damage.newCopy(self)
        
        if s != nil
          if s.size < danio.nShields
            danio.nShields = s.size
          end
        else
          danio.nShields = 0
        end

        if danio.nWeapons != @@NO_USE
          if w != nil
            if w.size < danio.nWeapons
              danio.nWeapons = w.size
            end
          else
            danio.nWeapons = 0
          end
          
        else
          i = 0
          copiaw = []
          if w == nil
            copiaw = []
          else
            w.each do |weap|
              copiaw.push(weap)
            end
          end
          
          if danio.weapons != nil
            while i < danio.weapons.size
              indice = arrayContainsType(copiaw, danio.weapons[i].type)
              if indice == -1
                danio.weapons.delete_at(i)
              else
                copiaw.delete_at(indice)
                i += 1
              end

            end
          end

        end
        
        return danio

      end


      def to_s
        out = "NShields: " + nShields.to_s + "\nNWeapons: " + nWeapons.to_s + "\nWeapons:\n"

        if weapons != nil
          @weapons.each_with_index do |s,i|
            out += ("weapon " + (i+1).to_s + ": \n" + s.to_s + "\n")
          end
        end
        
        return out
      end

      def getUIversion
        DamageToUI.new(self) 
      end

    end

end    