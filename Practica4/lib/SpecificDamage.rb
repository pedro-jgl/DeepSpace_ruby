# encoding: utf-8

require_relative 'SpecificDamageToUI'
require_relative 'Damage'

module Deepspace

    class SpecificDamage < Damage
        def initialize(wl,s)
            super(s)
            @weapons = wl

        end

        public_class_method :new

        def self.newCopy(d)
            new(d.weapons, d.nShields)

        end

        def copy
            return SpecificDamage.newCopy(self)
        end
        
        attr_accessor :nShields

        def weapons
            return @weapons

        end

        def discardWeapon(w)
            index = @weapons.index(w.type)
            if index != nil
                @weapons.delete_at(index)
            end

        end

        def hasNoEffect
            noeffect = false

            if @weapons.empty? && super
                noeffect = true
            end

            return noeffect
        end


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

        private :arrayContainsType

        def adjust(w,s)
            danio = copy

            danio.adjust_shields(s)

            i = 0
            copiaw = Array.new
            if w != nil
                w.each do |weap|
                copiaw.push(weap)
                end
            end
            
            if danio.weapons != nil
                while i < danio.weapons.size
                    indice = arrayContainsType(copiaw, danio.weapons[i])
                    if indice == -1
                        danio.weapons.delete_at(i)
                    else
                        copiaw.delete_at(indice)
                        i += 1
                    end

                end
            end

            return danio
        end

        def to_s
            out = super 
            out += "\nWeapons:\n"
    
            if @weapons != nil
              @weapons.each_with_index do |s,i|
                out += ("weapon " + (i+1).to_s + ": \n" + s.to_s + "\n")
              end
            end
            
            return out
            
        end


        def getUIversion
            SpecificDamageToUI.new(self) 
          end

    end

end