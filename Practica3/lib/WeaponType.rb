# encoding: utf-8

module Deepspace
  module WeaponType
    class Type 
    
      def initialize(p)
        @power = p  
      end

      def getPower
        return @power
      end

      def to_s
        if self == WeaponType::LASER
          return "LASER"
        elsif self == WeaponType::MISSILE
          return "MISSILE"
        else 
          return "PLASMA"
        end
      end

    end

    LASER   = Type.new(2.0)
    MISSILE = Type.new(3.0)
    PLASMA  = Type.new(4.0)

  end
end