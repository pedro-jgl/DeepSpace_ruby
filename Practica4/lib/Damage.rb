# encoding: utf-8
require_relative 'DamageToUI'

module Deepspace

    class Damage

      def initialize(s)
        @nShields = s
      end

      private_class_method :new

      def self.newCopy(d)
        new(d.nShields)
      end

      def copy 
      end
      
      attr_accessor :nShields

      def discardWeapon
      end

      def discardShieldBooster
        if @nShields > 0
          @nShields = @nShields - 1
        end
      end

      def hasNoEffect
          return (nShields == 0)

      end


      public
      def adjust_shields(s)
        if s != nil
          nShields = [nShields,s.size].min
        else
          nShields = 0
        end

      end


      def adjust(w, s)
      end


      def to_s
        out = "NShields: " + nShields.to_s  

        return out

      end


      def getUIversion
        DamageToUI.new(self) 
      end

    end

end    