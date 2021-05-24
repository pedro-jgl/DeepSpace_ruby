# encoding: utf-8

require_relative 'NumericDamageToUI'
require_relative 'Damage'

module Deepspace

    class NumericDamage < Damage

        def initialize(w,s)
            super(s)
            @nWeapons = w 

        end 

        public_class_method :new

        attr_accessor :nShields
        attr_accessor :nWeapons

        def self.newCopy(d)
            new(d.nWeapons, d.nShields)

        end

        def copy 
            return NumericDamage.newCopy(self)
        end


        #Yo lo declararía sin el parámetro de entrada, ya que no se usa,
        #pero no sé si en los archivos que ha pasado el profesor, llama a 
        #este método con parámetro
        def discardWeapon(w)
            if @nWeapons > 0
                @nWeapons -= 1
            end
        
        end


        def hasNoEffect
            noeffect = false

            if @nWeapons == 0 && super
                noeffect = true
            end

            return noeffect
        
        end


        def adjust(w,s)
            danio = copy

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
            out += ("\nNWeapons: " + @nWeapons.to_s) 

            return out

        end


        def getUIversion
            NumericDamageToUI.new(self) 
        end
    end

end