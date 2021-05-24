#encoding:utf-8

require_relative 'SpaceStation'
require_relative 'Transformation'

module DeepSpace
    class PowerEfficientSpaceStation < SpaceStation
        @@EFFICIENCYFACTOR=1.10

        def initialize(station)
            newCopy(station)
        end

        def fire
            return super * @@EFFICIENCYFACTOR
        end

        def protecction
            return super * @@EFFICIENCYFACTOR
        end

        def setLoot(loot)
            super

            if loot.getEfficient == Transformation::GETEFFICIENT
                return Transformation::GETEFFICIENT
            else
                return Transformation::NOTRANSFORM
            end
        end
        
        def getUIversion
            PowerEfficientSpaceStationToUI.new(self)
        end

        
        def to_s
            return " POWER EFFICICENT SPACESTATION\n" + super
          end
    end
end