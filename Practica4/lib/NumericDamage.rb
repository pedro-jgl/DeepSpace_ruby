# encoding: utf-8

module Deepspace

    class NumericDamage < Damage

        def initialize(s,w)
            super(s)
            @nWeapons = w 

        end 

        public_class_method :new

        #Se añade también attr_reader de nShields?
        attr_accessor :nWeapons

        def self.newCopy(d)
            new(d.nShields,d.nWeapons)

        end

        def copy 
            return NumericDamage.newCopy(self)
        end


        #Yo lo declararía sin el parámetro de entrada, ya que no se usa,
        #pero no sé si en los archivos que ha pasado el profesor, llama a 
        #este método con parámetro
        def discardWeapon(w)
            if nWeapons > 0
                nWeapons -= 1
            end
        
        end


        def hasNoEffect
            noeffect = false

            if nWeapons == 0 && super
                noeffect = true
            end

            return noeffect
        
        end


        def adjust(w,s)
            danio = NumericDamage.newCopy(self)

            danio.adjust_shields(s)

            if w != nil
                danio.nWeapons = [nWeapons,w.size].min
            else
                danio.nWeapons = 0
            end

            return danio
        
        end


        def to_s
            out = super 
            out += ("\nNWeapons: " + nWeapons.to_s) 

            return out

        end


        def getUIversion
            NumericDamageToUI.new(self) 
          end


    end

end